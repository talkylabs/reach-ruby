.PHONY: githooks install test test-docker lint docs docker-build docker-push

githooks:
	ln -sf ../../githooks/pre-commit .git/hooks/pre-commit

install:
	bundle install --with development; bundle exec rake install

test:
	bundle exec rake spec

test-docker:
	docker build -t talkylabs/reach-ruby .
	docker run talkylabs/reach-ruby bundle exec rake spec

docs:
	bundle exec yard doc --output-dir ./doc

authors:
	echo "Authors\n=======\n\nA huge thanks to all of our contributors:\n\n" > AUTHORS.md
	git log --raw | grep "^Author: " | cut -d ' ' -f2- | cut -d '<' -f1 | sed 's/^/- /' | sort | uniq >> AUTHORS.md

API_DEFINITIONS_SHA=$(shell git log --oneline | grep Regenerated | head -n1 | cut -d ' ' -f 5)
CURRENT_TAG=$(shell expr "${GITHUB_TAG}" : ".*-rc.*" >/dev/null && echo "rc" || echo "latest")
docker-build:
	docker build -t talkylabs/reach-ruby .
	docker tag talkylabs/reach-ruby talkylabs/reach-ruby:${GITHUB_TAG}
	docker tag talkylabs/reach-ruby talkylabs/reach-ruby:apidefs-${API_DEFINITIONS_SHA}
	docker tag talkylabs/reach-ruby talkylabs/reach-ruby:${CURRENT_TAG}

docker-push:
	docker push talkylabs/reach-ruby:${GITHUB_TAG}
	docker push talkylabs/reach-ruby:apidefs-${API_DEFINITIONS_SHA}
	docker push talkylabs/reach-ruby:${CURRENT_TAG}

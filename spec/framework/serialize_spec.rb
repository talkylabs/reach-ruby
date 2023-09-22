require 'spec_helper'

describe Reach do
  describe 'prefixed_collapsible_map' do
    it 'should serialize nil' do
      actual = Reach.prefixed_collapsible_map(nil, 'Prefix')
      expect(actual).to eq({})
    end

    it 'should serialize a single key' do
      actual = Reach.prefixed_collapsible_map({ 'foo' => 'bar' }, 'Prefix')
      expect(actual).to eq('Prefix.foo' => 'bar')
    end

    it 'should serialize nested key' do
      actual = Reach.prefixed_collapsible_map({
                                                 'foo' => {
                                                   'bar' => 'baz'
                                                 }
                                               }, 'Prefix')
      expect(actual).to eq('Prefix.foo.bar' => 'baz')
    end

    it 'should serialize multiple keys' do
      actual = Reach.prefixed_collapsible_map({
                                                 'watson' => {
                                                   'language' => 'en',
                                                   'alice' => 'bob'
                                                 },
                                                 'foo' => 'bar'
                                               }, 'Prefix')
      expect(actual).to eq('Prefix.watson.language' => 'en',
                           'Prefix.watson.alice' => 'bob',
                           'Prefix.foo' => 'bar')
    end

    it 'should serialize list' do
      actual = Reach.prefixed_collapsible_map(['foo', 'bar'], 'Prefix')
      expect(actual).to eq({})
    end
  end

  describe 'serialize_object' do
    it 'should jsonify hashes' do
      actual = Reach.serialize_object({ reach: "rocks" })
      expect(actual).to eq('{"reach":"rocks"}')
    end

    it 'should jsonify arrays' do
      actual = Reach.serialize_object(["reach", "rocks"])
      expect(actual).to eq('["reach","rocks"]')
    end

    it 'should not modify other types' do
      actual = Reach.serialize_object(123)
      expect(actual).to eq(123)
    end
  end

  describe 'serialize_list' do
    it 'should only operate on things with .each method' do
      actual = Reach.serialize_list(nil)
      expect(actual).to eq(nil)

      actual = Reach.serialize_list("something")
      expect(actual).to eq("something")

      actual = Reach.serialize_list(1)
      expect(actual).to eq(1)

      actual = Reach.serialize_list({ some_obj: 'some_val' })
      expect(actual).to eq({ some_obj: 'some_val' })
    end

    it 'should apply block to every element in list' do
      actual = Reach.serialize_list([1, 2, 3, 4]) { |e| e * 2 }
      expect(actual).to eq([2, 4, 6, 8])
    end
  end
end

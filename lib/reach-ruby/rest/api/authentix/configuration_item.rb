##
#    This code was generated by
#  ___ ___   _   ___ _  _    _____ _   _    _  ___   ___      _   ___ ___      ___   _   ___     ___ ___ _  _ ___ ___    _ _____ ___  ___ 
# | _ \ __| /_\ / __| || |__|_   _/_\ | |  | |/ | \ / / |    /_\ | _ ) __|___ / _ \ /_\ |_ _|__ / __| __| \| | __| _ \  /_\_   _/ _ \| _ \
# |   / _| / _ \ (__| __ |___|| |/ _ \| |__| ' < \ V /| |__ / _ \| _ \__ \___| (_) / _ \ | |___| (_ | _|| .` | _||   / / _ \| || (_) |   /
# |_|_\___/_/ \_\___|_||_|    |_/_/ \_\____|_|\_\ |_| |____/_/ \_\___/___/    \___/_/ \_\___|   \___|___|_|\_|___|_|_\/_/ \_\_| \___/|_|_\
# 
#    Reach Authentix API
#     Reach Authentix API helps you easily integrate user authentification in your application. The authentification allows to verify that a user is indeed at the origin of a request from your application.  At the moment, the Reach Authentix API supports the following channels:    * SMS      * Email   We are continuously working to add additionnal channels. ## Base URL All endpoints described in this documentation are relative to the following base URL: ``` https://api.reach.talkylabs.com/rest/authentix/v1/ ```  The API is provided over HTTPS protocol to ensure data privacy.  ## API Authentication Requests made to the API must be authenticated. You need to provide the `ApiUser` and `ApiKey` associated with your applet. This information could be found in the settings of the applet. ```curl curl -X GET [BASE_URL]/configurations -H \"ApiUser:[Your_Api_User]\" -H \"ApiKey:[Your_Api_Key]\" ``` ## Reach Authentix API Workflow Three steps are needed in order to authenticate a given user using the Reach Authentix API. ### Step 1: Create an Authentix configuration A configuration is a set of settings used to define and send an authentication code to a user. This includes, for example: ```   - the length of the authentication code,    - the message template,    - and so on... ``` A configuaration could be created via the web application or directly using the Reach Authentix API. This step does not need to be performed every time one wants to use the Reach Authentix API. Indeed, once created, a configuartion could be used to authenticate several users in the future.    ### Step 2: Send an authentication code A configuration is used to send an authentication code via a selected channel to a user. For now, the supported channels are `sms`, and `email`. We are working hard to support additional channels. Newly created authentications will have a status of `awaiting`. ### Step 3: Verify the authentication code This step allows to verify that the code submitted by the user matched the one sent previously. If, there is a match, then the status of the authentication changes from `awaiting` to `passed`. Otherwise, the status remains `awaiting` until either it is verified or it expires. In the latter case, the status becomes `expired`. 
#
#    NOTE: This class is auto generated by OpenAPI Generator.
#    https://openapi-generator.tech
#    Do not edit the class manually.
#


module Reach
    module REST
        class Api
            class Authentix < Version
                class ConfigurationItemList < ListResource
                    ##
                    # Initialize the ConfigurationItemList
                    # @param [Version] version Version that contains the resource
                    # @return [ConfigurationItemList] ConfigurationItemList
                    def initialize(version)
                        super(version)
                        # Path Solution
                        @solution = {  }
                        @uri = "/authentix/v1/configurations"
                        
                    end
                    ##
                    # Create the ConfigurationItemInstance
                    # @param [String] service_name The name of the authentication service attached to this configuration. It can be up to 40 characters long.
                    # @param [String] code_length The length of the code to be generated. It must be a value between 4 and 10, inclusive. If not specified, the default value is 5.
                    # @param [Boolean] allow_custom_code A flag indicating if the configuration should allow sending custom and non-generated code.
                    # @param [Boolean] used_for_digital_payment A flag indicating if the configuration is used to authenticate digital payments. In such a case, additional information such as the amount and the payee of the financial transaction should be sent to when starting the authentication.
                    # @param [String] default_expiry_time It represents how long, in minutes, an authentication process will remained in the `awaiting` status before moving to `expired` in the case no valid matching is performed in between.   It also means that the code sent for the autentication remains the same during its validity period until the autentication is successful. In other words, if another authentication request is asked within that period, the same code will be sent.  If not specified, the default value is 15 minutes. It must be any value between 1 and 1440 which represents 24 hours. 
                    # @param [String] default_max_trials It represents the maximum number of trials per authentication. The default value is 5. 
                    # @param [String] default_max_controls It represents the maximum number of code controls per authentication. It must be between 1 and 6 inclusive. The default value is 3. 
                    # @param [String] smtp_setting_id This is the ID of the SMTP settings used by this configuration. It is mandatory to provide this parameter in order to send the authentication code via email. An SMTPSetting can be created via the web application in an easy way.
                    # @param [String] email_template_id This is the ID of the default email template to use for sending authenetication codes via email. If not provided, the message used will be:   ```    ${SERVICE_NAME}: your authentication code is ${CODE}.  ```   
                    # @param [String] sms_template_id This is the ID of the default sms template to use for sending authenetication codes via sms. If not provided, the message used will be:   ```    ${SERVICE_NAME}: your authentication code is ${CODE}.  ``` 
                    # @return [ConfigurationItemInstance] Created ConfigurationItemInstance
                    def create(
                        service_name: nil, 
                        code_length: :unset, 
                        allow_custom_code: :unset, 
                        used_for_digital_payment: :unset, 
                        default_expiry_time: :unset, 
                        default_max_trials: :unset, 
                        default_max_controls: :unset, 
                        smtp_setting_id: :unset, 
                        email_template_id: :unset, 
                        sms_template_id: :unset
                    )

                        baseParams = {
                        }
                        data = Reach::Values.of(baseParams.merge({                        
                            'serviceName' => service_name,
                            'codeLength' => code_length,
                            'allowCustomCode' => allow_custom_code,
                            'usedForDigitalPayment' => used_for_digital_payment,
                            'defaultExpiryTime' => default_expiry_time,
                            'defaultMaxTrials' => default_max_trials,
                            'defaultMaxControls' => default_max_controls,
                            'smtpSettingId' => smtp_setting_id,
                            'emailTemplateId' => email_template_id,
                            'smsTemplateId' => sms_template_id,
                        }))

                        
                        
                        payload = @version.create('POST', @uri, data: data)
                        ConfigurationItemInstance.new(
                            @version,
                            payload,
                        )
                    end

                
                    ##
                    # Lists ConfigurationItemInstance records from the API as a list.
                    # Unlike stream(), this operation is eager and will load `limit` records into
                    # memory before returning.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Array] Array of up to limit results
                    def list(limit: nil, page_size: nil)
                        self.stream(
                            limit: limit,
                            page_size: page_size
                        ).entries
                    end

                    ##
                    # Streams Instance records from the API as an Enumerable.
                    # This operation lazily loads records as efficiently as possible until the limit
                    # is reached.
                    # @param [Integer] limit Upper limit for the number of records to return. stream()
                    #    guarantees to never return more than limit.  Default is no limit
                    # @param [Integer] page_size Number of records to fetch per request, when
                    #    not set will use the default value of 50 records.  If no page_size is defined
                    #    but a limit is defined, stream() will attempt to read the limit with the most
                    #    efficient page size, i.e. min(limit, 1000)
                    # @return [Enumerable] Enumerable that will yield up to limit results
                    def stream(limit: nil, page_size: nil)
                        limits = @version.read_limits(limit, page_size)

                        page = self.page(
                            page_size: limits[:page_size], )

                        @version.stream(page, limit: limits[:limit], page_limit: limits[:page_limit])
                    end

                    ##
                    # When passed a block, yields ConfigurationItemInstance records from the API.
                    # This operation lazily loads records as efficiently as possible until the limit
                    # is reached.
                    def each
                        limits = @version.read_limits

                        page = self.page(page_size: limits[:page_size], )

                        @version.stream(page,
                            limit: limits[:limit],
                            page_limit: limits[:page_limit]).each {|x| yield x}
                    end

                    ##
                    # Retrieve a single page of ConfigurationItemInstance records from the API.
                    # Request is executed immediately.
                    # @param [Integer] page_number Page Number, this value is simply for client state
                    # @param [Integer] page_size Number of records to return, defaults to 20
                    # @return [Page] Page of ConfigurationItemInstance
                    def page(page_token: :unset, page_number: :unset, page_size: :unset)
                        params = Reach::Values.of({
                            
                            'page' => page_number,
                            'pageSize' => page_size,
                        })

                        baseUrl = @version.url_without_pagination_info(@version.absolute_url(@uri), params)
                        response = @version.page('GET', @uri, params: params)

                        ConfigurationItemPage.new(baseUrl, @version, response, @solution)
                    end

                    ##
                    # Retrieve a single page of ConfigurationItemInstance records from the API.
                    # Request is executed immediately.
                    # @param [String] target_url API-generated URL for the requested results page
                    # @return [Page] Page of ConfigurationItemInstance
                    def get_page(target_url)
                        baseUrl = @version.url_without_pagination_info(target_url)
                        response = @version.domain.request(
                            'GET',
                            target_url
                        )
                    ConfigurationItemPage.new(baseUrl, @version, response, @solution)
                    end
                    


                    # Provide a user friendly representation
                    def to_s
                        '#<Reach.Api.Authentix.ConfigurationItemList>'
                    end
                end


                class ConfigurationItemContext < InstanceContext
                    ##
                    # Initialize the ConfigurationItemContext
                    # @param [Version] version Version that contains the resource
                    # @param [String] configuration_id The identifier of the configuration to be updated.
                    # @return [ConfigurationItemContext] ConfigurationItemContext
                    def initialize(version, configuration_id)
                        super(version)

                        # Path Solution
                        @solution = { configuration_id: configuration_id,  }
                        @uri = "/authentix/v1/configurations/#{@solution[:configuration_id]}"

                        # Dependents
                        @authentication_control_items = nil
                        @authentication_items = nil
                    end
                    ##
                    # Delete the ConfigurationItemInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        baseParams = {
                        }
                        
                        
                        @version.delete('DELETE', @uri)
                    end

                    ##
                    # Fetch the ConfigurationItemInstance
                    # @return [ConfigurationItemInstance] Fetched ConfigurationItemInstance
                    def fetch

                        baseParams = {
                        }
                        
                        
                        payload = @version.fetch('GET', @uri)
                        ConfigurationItemInstance.new(
                            @version,
                            payload,
                            configuration_id: @solution[:configuration_id],
                        )
                    end

                    ##
                    # Update the ConfigurationItemInstance
                    # @param [String] service_name The name of the authentication service attached to this configuration. It can be up to 40 characters long.
                    # @param [String] code_length The length of the code to be generated. It must be a value between 4 and 10, inclusive.
                    # @param [Boolean] allow_custom_code A flag indicating if the configuration should allow sending custom and non-generated code.
                    # @param [Boolean] used_for_digital_payment A flag indicating if the configuration is used to authenticate digital payments. In such a case, additional information such as the amount and the payee of the financial transaction should be sent to when starting the authentication.
                    # @param [String] default_expiry_time It represents how long, in minutes, an authentication process will remained in the `awaiting` status before moving to `expired` in the case no valid matching is performed in between. It must be any value between 1 and 1440 which represents 24 hours.
                    # @param [String] default_max_trials It represents the maximum number of trials per authentication. 
                    # @param [String] default_max_controls It represents the maximum number of code controls per authentication. It must be between 1 and 6 inclusive. 
                    # @param [String] smtp_setting_id This is the ID of the SMTP settings used by this configuration. It is mandatory for sending authentication codes via email.
                    # @param [String] email_template_id This is the ID of the default email template to use for sending authenetication codes via email. 
                    # @param [String] sms_template_id This is the ID of the default sms template to use for sending authenetication codes via sms. 
                    # @return [ConfigurationItemInstance] Updated ConfigurationItemInstance
                    def update(
                        service_name: :unset, 
                        code_length: :unset, 
                        allow_custom_code: :unset, 
                        used_for_digital_payment: :unset, 
                        default_expiry_time: :unset, 
                        default_max_trials: :unset, 
                        default_max_controls: :unset, 
                        smtp_setting_id: :unset, 
                        email_template_id: :unset, 
                        sms_template_id: :unset
                    )

                        baseParams = {
                        }
                        data = Reach::Values.of(baseParams.merge({                        
                            'serviceName' => service_name,
                            'codeLength' => code_length,
                            'allowCustomCode' => allow_custom_code,
                            'usedForDigitalPayment' => used_for_digital_payment,
                            'defaultExpiryTime' => default_expiry_time,
                            'defaultMaxTrials' => default_max_trials,
                            'defaultMaxControls' => default_max_controls,
                            'smtpSettingId' => smtp_setting_id,
                            'emailTemplateId' => email_template_id,
                            'smsTemplateId' => sms_template_id,
                        }))

                        
                        
                        payload = @version.update('POST', @uri, data: data)
                        ConfigurationItemInstance.new(
                            @version,
                            payload,
                            configuration_id: @solution[:configuration_id],
                        )
                    end

                    ##
                    # Access the authentication_control_items
                    # @return [AuthenticationControlItemList]
                    # @return [AuthenticationControlItemContext]
                    def authentication_control_items
                      unless @authentication_control_items
                        @authentication_control_items = AuthenticationControlItemList.new(
                                @version,
                                configuration_id: @solution[:configuration_id]
                                
                                )
                      end

                      @authentication_control_items
                    end
                    ##
                    # Access the authentication_items
                    # @return [AuthenticationItemList]
                    # @return [AuthenticationItemContext] if sid was passed.
                    def authentication_items(authentication_id=:unset)

                        raise ArgumentError, 'authentication_id cannot be nil' if authentication_id.nil?

                        if authentication_id != :unset
                            return AuthenticationItemContext.new(@version, @solution[:configuration_id],authentication_id )
                        end

                        unless @authentication_items
                            @authentication_items = AuthenticationItemList.new(
                                @version,
                                configuration_id: @solution[:configuration_id]
                                
                                )
                        end

                     @authentication_items
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Reach.Api.Authentix.ConfigurationItemContext #{context}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        context = @solution.map{|k, v| "#{k}: #{v}"}.join(',')
                        "#<Reach.Api.Authentix.ConfigurationItemContext #{context}>"
                    end
                end

                class ConfigurationItemPage < Page
                    ##
                    # Initialize the ConfigurationItemPage
                    # @param [String] baseUrl url without pagination info
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [ConfigurationItemPage] ConfigurationItemPage
                    def initialize(baseUrl, version, response, solution)
                        super(baseUrl, version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of ConfigurationItemInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [ConfigurationItemInstance] ConfigurationItemInstance
                    def get_instance(payload)
                        ConfigurationItemInstance.new(@version, payload)
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Reach.Api.Authentix.ConfigurationItemPage>'
                    end
                end
                class ConfigurationItemInstance < InstanceResource
                    ##
                    # Initialize the ConfigurationItemInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Reach(TalkyLabs)
                    # @param [String] account_sid The SID of the
                    #   Account that created this ConfigurationItem
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [ConfigurationItemInstance] ConfigurationItemInstance
                    def initialize(version, payload , configuration_id: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'appletId' => payload['appletId'],
                            'apiVersion' => payload['apiVersion'],
                            'configurationId' => payload['configurationId'],
                            'serviceName' => payload['serviceName'],
                            'codeLength' => payload['codeLength'] == nil ? payload['codeLength'] : payload['codeLength'].to_i,
                            'allowCustomCode' => payload['allowCustomCode'],
                            'usedForDigitalPayment' => payload['usedForDigitalPayment'],
                            'defaultExpiryTime' => payload['defaultExpiryTime'] == nil ? payload['defaultExpiryTime'] : payload['defaultExpiryTime'].to_i,
                            'defaultMaxTrials' => payload['defaultMaxTrials'] == nil ? payload['defaultMaxTrials'] : payload['defaultMaxTrials'].to_i,
                            'defaultMaxControls' => payload['defaultMaxControls'] == nil ? payload['defaultMaxControls'] : payload['defaultMaxControls'].to_i,
                            'smtpSettingId' => payload['smtpSettingId'],
                            'emailTemplateId' => payload['emailTemplateId'],
                            'smsTemplateId' => payload['smsTemplateId'],
                            'dateCreated' => Reach.deserialize_iso8601_datetime(payload['dateCreated']),
                            'dateUpdated' => Reach.deserialize_iso8601_datetime(payload['dateUpdated']),
                        }

                        # Context
                        @instance_context = nil
                        @params = { 'configuration_id' => configuration_id  || @properties['configurationId']  , }
                    end

                    ##
                    # Generate an instance context for the instance, the context is capable of
                    # performing various actions.  All instance actions are proxied to the context
                    # @return [ConfigurationItemContext] CallContext for this CallInstance
                    def context
                        unless @instance_context
                            @instance_context = ConfigurationItemContext.new(@version , @params['configuration_id'])
                        end
                        @instance_context
                    end
                    
                    ##
                    # @return [String] The identifier of the applet creating the configuration.
                    def appletId
                        @properties['appletId']
                    end
                    
                    ##
                    # @return [String] The API version used to create the configuration.
                    def apiVersion
                        @properties['apiVersion']
                    end
                    
                    ##
                    # @return [String] The identifier of the configuration.
                    def configurationId
                        @properties['configurationId']
                    end
                    
                    ##
                    # @return [String] The name of the authentication service.
                    def serviceName
                        @properties['serviceName']
                    end
                    
                    ##
                    # @return [String] The length of the code to be generated.
                    def codeLength
                        @properties['codeLength']
                    end
                    
                    ##
                    # @return [Boolean] A flag indicating if the configuration allows sending custom and non-generated code.
                    def allowCustomCode
                        @properties['allowCustomCode']
                    end
                    
                    ##
                    # @return [Boolean] A flag indicating if the configuration is used to authenticate digital payments.
                    def usedForDigitalPayment
                        @properties['usedForDigitalPayment']
                    end
                    
                    ##
                    # @return [String] the default expiry time of the authentication code.
                    def defaultExpiryTime
                        @properties['defaultExpiryTime']
                    end
                    
                    ##
                    # @return [String] the default maximum number of trials per authentication.
                    def defaultMaxTrials
                        @properties['defaultMaxTrials']
                    end
                    
                    ##
                    # @return [String] the default maximum number of code controls per authentication.
                    def defaultMaxControls
                        @properties['defaultMaxControls']
                    end
                    
                    ##
                    # @return [String] The ID of the SMTP settings used by the configuration.
                    def smtpSettingId
                        @properties['smtpSettingId']
                    end
                    
                    ##
                    # @return [String] The default email template ID used by this configuration. 
                    def emailTemplateId
                        @properties['emailTemplateId']
                    end
                    
                    ##
                    # @return [String] The default sms template ID used by this configuration. 
                    def smsTemplateId
                        @properties['smsTemplateId']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT that the configuration was created. 
                    def dateCreated
                        @properties['dateCreated']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT that the configuration was last updated. 
                    def dateUpdated
                        @properties['dateUpdated']
                    end
                    
                    ##
                    # Delete the ConfigurationItemInstance
                    # @return [Boolean] True if delete succeeds, false otherwise
                    def delete

                        context.delete
                    end

                    ##
                    # Fetch the ConfigurationItemInstance
                    # @return [ConfigurationItemInstance] Fetched ConfigurationItemInstance
                    def fetch

                        context.fetch
                    end

                    ##
                    # Update the ConfigurationItemInstance
                    # @param [String] service_name The name of the authentication service attached to this configuration. It can be up to 40 characters long.
                    # @param [String] code_length The length of the code to be generated. It must be a value between 4 and 10, inclusive.
                    # @param [Boolean] allow_custom_code A flag indicating if the configuration should allow sending custom and non-generated code.
                    # @param [Boolean] used_for_digital_payment A flag indicating if the configuration is used to authenticate digital payments. In such a case, additional information such as the amount and the payee of the financial transaction should be sent to when starting the authentication.
                    # @param [String] default_expiry_time It represents how long, in minutes, an authentication process will remained in the `awaiting` status before moving to `expired` in the case no valid matching is performed in between. It must be any value between 1 and 1440 which represents 24 hours.
                    # @param [String] default_max_trials It represents the maximum number of trials per authentication. 
                    # @param [String] default_max_controls It represents the maximum number of code controls per authentication. It must be between 1 and 6 inclusive. 
                    # @param [String] smtp_setting_id This is the ID of the SMTP settings used by this configuration. It is mandatory for sending authentication codes via email.
                    # @param [String] email_template_id This is the ID of the default email template to use for sending authenetication codes via email. 
                    # @param [String] sms_template_id This is the ID of the default sms template to use for sending authenetication codes via sms. 
                    # @return [ConfigurationItemInstance] Updated ConfigurationItemInstance
                    def update(
                        service_name: :unset, 
                        code_length: :unset, 
                        allow_custom_code: :unset, 
                        used_for_digital_payment: :unset, 
                        default_expiry_time: :unset, 
                        default_max_trials: :unset, 
                        default_max_controls: :unset, 
                        smtp_setting_id: :unset, 
                        email_template_id: :unset, 
                        sms_template_id: :unset
                    )

                        context.update(
                            service_name: service_name, 
                            code_length: code_length, 
                            allow_custom_code: allow_custom_code, 
                            used_for_digital_payment: used_for_digital_payment, 
                            default_expiry_time: default_expiry_time, 
                            default_max_trials: default_max_trials, 
                            default_max_controls: default_max_controls, 
                            smtp_setting_id: smtp_setting_id, 
                            email_template_id: email_template_id, 
                            sms_template_id: sms_template_id, 
                        )
                    end

                    ##
                    # Access the authentication_control_items
                    # @return [authentication_control_items] authentication_control_items
                    def authentication_control_items
                        context.authentication_control_items
                    end

                    ##
                    # Access the authentication_items
                    # @return [authentication_items] authentication_items
                    def authentication_items
                        context.authentication_items
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        values = @params.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Reach.Api.Authentix.ConfigurationItemInstance #{values}>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        values = @properties.map{|k, v| "#{k}: #{v}"}.join(" ")
                        "<Reach.Api.Authentix.ConfigurationItemInstance #{values}>"
                    end
                end

            end
        end
    end
end

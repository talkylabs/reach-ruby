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
                class ConfigurationItemContext < InstanceContext

                     class AuthenticationControlItemList < ListResource
                    ##
                    # Initialize the AuthenticationControlItemList
                    # @param [Version] version Version that contains the resource
                    # @return [AuthenticationControlItemList] AuthenticationControlItemList
                    def initialize(version, configuration_id: nil)
                        super(version)
                        # Path Solution
                        @solution = { configuration_id: configuration_id }
                        @uri = "/authentix/v1/configurations/#{@solution[:configuration_id]}/authentication-controls"
                        
                    end
                    ##
                    # Check the AuthenticationControlItemInstance
                    # @param [String] dest The phone number or email being authenticated. Phone numbers must be in E.164 format. Either this parameter or the `authenticationId` must be specified.
                    # @param [String] code The 4-10 character string being verified. This is required for `sms` and `email` channels.
                    # @param [String] authentication_id The ID of the authentication being checked. Either this parameter or the to `dest` must be specified.
                    # @param [String] payment_info Information related to the digital payment to authenticate. It is required when `usedForDigitalPayment` is true. It is ignored otherwise. It is a stringfied JSON map where keys are `payee`, `amount`, and `currency` and the associated values are respectively the payee, the amount, and the currency of a financial transaction. 
                    # @return [AuthenticationControlItemInstance] Checkd AuthenticationControlItemInstance
                    def check(
                        dest: :unset, 
                        code: :unset, 
                        authentication_id: :unset, 
                        payment_info: :unset
                    )

                        baseParams = {
                        }
                        data = Reach::Values.of(baseParams.merge({                        
                            'dest' => dest,
                            'code' => code,
                            'authenticationId' => authentication_id,
                            'paymentInfo' => payment_info,
                        }))

                        
                        
                        payload = @version.check('POST', @uri, data: data)
                        AuthenticationControlItemInstance.new(
                            @version,
                            payload,
                            configuration_id: @solution[:configuration_id],
                        )
                    end

                


                    # Provide a user friendly representation
                    def to_s
                        '#<Reach.Api.Authentix.AuthenticationControlItemList>'
                    end
                end

                class AuthenticationControlItemPage < Page
                    ##
                    # Initialize the AuthenticationControlItemPage
                    # @param [String] baseUrl url without pagination info
                    # @param [Version] version Version that contains the resource
                    # @param [Response] response Response from the API
                    # @param [Hash] solution Path solution for the resource
                    # @return [AuthenticationControlItemPage] AuthenticationControlItemPage
                    def initialize(baseUrl, version, response, solution)
                        super(baseUrl, version, response)

                        # Path Solution
                        @solution = solution
                    end

                    ##
                    # Build an instance of AuthenticationControlItemInstance
                    # @param [Hash] payload Payload response from the API
                    # @return [AuthenticationControlItemInstance] AuthenticationControlItemInstance
                    def get_instance(payload)
                        AuthenticationControlItemInstance.new(@version, payload, configuration_id: @solution[:configuration_id])
                    end

                    ##
                    # Provide a user friendly representation
                    def to_s
                        '<Reach.Api.Authentix.AuthenticationControlItemPage>'
                    end
                end
                class AuthenticationControlItemInstance < InstanceResource
                    ##
                    # Initialize the AuthenticationControlItemInstance
                    # @param [Version] version Version that contains the resource
                    # @param [Hash] payload payload that contains response from Reach(TalkyLabs)
                    # @param [String] account_sid The SID of the
                    #   Account that created this AuthenticationControlItem
                    #   resource.
                    # @param [String] sid The SID of the Call resource to fetch.
                    # @return [AuthenticationControlItemInstance] AuthenticationControlItemInstance
                    def initialize(version, payload , configuration_id: nil)
                        super(version)
                        
                        # Marshaled Properties
                        @properties = { 
                            'appletId' => payload['appletId'],
                            'apiVersion' => payload['apiVersion'],
                            'configurationId' => payload['configurationId'],
                            'authenticationId' => payload['authenticationId'],
                            'status' => payload['status'],
                            'dest' => payload['dest'],
                            'channel' => payload['channel'],
                            'paymentInfo' => payload['paymentInfo'],
                            'dateCreated' => Reach.deserialize_iso8601_datetime(payload['dateCreated']),
                            'dateUpdated' => Reach.deserialize_iso8601_datetime(payload['dateUpdated']),
                        }
                    end

                    
                    ##
                    # @return [String] The identifier of the applet.
                    def appletId
                        @properties['appletId']
                    end
                    
                    ##
                    # @return [String] The API version.
                    def apiVersion
                        @properties['apiVersion']
                    end
                    
                    ##
                    # @return [String] The identifier of the configuration.
                    def configurationId
                        @properties['configurationId']
                    end
                    
                    ##
                    # @return [String] The identifier of the authentication.
                    def authenticationId
                        @properties['authenticationId']
                    end
                    
                    ##
                    # @return [String] The outcome of the authentication control.
                    def status
                        @properties['status']
                    end
                    
                    ##
                    # @return [String] The phone number or email being verified. Phone numbers must be in E.164 format.
                    def dest
                        @properties['dest']
                    end
                    
                    ##
                    # @return [String] The channel used.
                    def channel
                        @properties['channel']
                    end
                    
                    ##
                    # @return [PaymentInfo] 
                    def paymentInfo
                        @properties['paymentInfo']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT that the authentication was created. 
                    def dateCreated
                        @properties['dateCreated']
                    end
                    
                    ##
                    # @return [Time] The date and time in GMT that the authentication was last updated. 
                    def dateUpdated
                        @properties['dateUpdated']
                    end
                    
                    ##
                    # Provide a user friendly representation
                    def to_s
                        "<Reach.Api.Authentix.AuthenticationControlItemInstance>"
                    end

                    ##
                    # Provide a detailed, user friendly representation
                    def inspect
                        "<Reach.Api.Authentix.AuthenticationControlItemInstance>"
                    end
                end

             end
            end
        end
    end
end


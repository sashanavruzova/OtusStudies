MODULE="OtusAppSwiftUI002/Networking/Sources/Networking"
OtusAppSwiftUI002/Networking/Sources/Networking

openapi-generator generate -i "newsapi.yml" -g swift5 -o "api-mobile"
rm -r $MODULE""*
cp -R "api-mobile/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "api-mobile"

# Debug OpenAPI Generator

<https://github.com/OpenAPITools/openapi-generator/pull/9537#discussion_r636963051>

```shell
java -DdebugModels -jar modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i modules/openapi-generator/src/test/resources/3_0/petstore.yaml -g c -o out/pet-new --enable-post-process-file  > out/pet.txt
```

You can replace -DdebugModels with -DdebugOperations and other flags.

- -DdebugModels is for printing template logs for all models
- -DdebugOperations is for printing template logs for all API's

You can find more debug flags here: https://github.com/openapitools/openapi-generator/wiki/FAQ#how-to-debug-openapi-generator.

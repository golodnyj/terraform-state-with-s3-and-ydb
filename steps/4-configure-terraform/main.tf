terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    // dynamodb_endpoint           = "https://docapi.serverless.yandexcloud.net/ru-central1/<CLOUD-ID>/<DATABASE-ID>"
    dynamodb_endpoint           = "<DYNAMODB_ENDPOINT>"
    region                      = "us-east-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    
    // состояние terraform будет сохранено в указанный bucket
    // bucket должен быть создан до вызова `terraform init`
    bucket                      = "<BUCKET-ID>"
    key                         = "<KEY>"

    // блокировка состояния будет храниться в указанной таблице
    // таблица должна быть создана до вызова `terraform init`
    // таблица должна быть создана в формате «Документальная таблица»
    // в таблице должен быть столбец `LockID` с типом (`string`) в качестве первичного ключа (Primary Key)
    
    dynamodb_table              = "<DYNAMODB_TABLE>"
    
    // Мы не пишем здесь access_key и secret_key
    // по соображениям безопасности 
    //
    // Используйте аргументы командной строки для команды `terraform init`, например:
    //     -backend-config="secret_key=<secret_value>"
  }
}
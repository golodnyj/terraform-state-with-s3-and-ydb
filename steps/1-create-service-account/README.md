# Service Account
## Создание

Создайте сервисный аккаунт с именем `terraform-service-account`: 

    yc iam service-account create --name terraform-service-account \
    --description "this is my service account for terraform"

Проверьте создание. Получите список доступных вам сервисных аккаунтов и запишите `SERVICE_ACCOUNT_ID`:
    
    yc iam service-account list

## Назначение ролей

Для работы с сервисами Object Storage и Yandex Database нашему сервисному аккаунту выдадим соответствующие права
`ydb.admin` и `storage.editor`. Для этого выполните следующие команды, предварительно заменив `FOLDER_ID` и `SERVICE_ACCOUNT_ID` на ваши значения.

    yc resource-manager folder add-access-binding <FOLDER_ID> \
    --role ydb.admin \
    --subject serviceAccount:<SERVICE_ACCOUNT_ID>

    yc resource-manager folder add-access-binding <FOLDER_ID> \
    --role storage.editor \
    --subject serviceAccount:<SERVICE_ACCOUNT_ID>

## Создание ключа доступа для сервисного аккаунта

Для создания ключа доступа необходимо вызвать следующую команду:

    yc iam access-key create --service-account-name terraform-service-account

В результате вы получите примерно следующее 

    access_key:
    id: ajefraollq5puj2tir1o
    service_account_id: ajetdv28pl0a1a8r41f0
    created_at: "2021-08-23T21:13:05.677319393Z"
    key_id: BTPNvWthv0ZX2xVmlPIU
    secret: cWLQ0HrTM0k_qAac43cwMNJA8VV_rfTg_kd4xVPi


Тут `key_id` — это идентификатор ключа доступа `ACCESS_KEY`. А `secret` — это секретный ключ `SECRET_KEY`. Эти переменные вы далее будете использовать при выполнении команды:
    
    terraform init -backend-config="access_key=<ACCESS_KEY>" -backend-config="secret_key=<SECRET_KEY>"

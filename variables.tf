variable "subscription_id" {
  description = "Azureサブスクリプションの識別ID"
  type        = string
}

variable "client_id" {
  description = "サービスプリンシパルのアプリケーションID"
  type        = string
}

variable "client_secret" {
  description = "サービスプリンシパルのクライアントシークレット（パスワード）"
  type        = string
  sensitive   = true
}
variable "tenant_id" {
  description = "AzureテナントのディレクトリID"
  type        = string
}

variable "tenant_domain" {
  description = "Azure Entra IDのプライマリドメイン名（例: example.onmicrosoft.com）。ユーザーのUPN（ログインID）作成に使用します。"
  type        = string
}

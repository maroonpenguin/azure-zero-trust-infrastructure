# Azure Zero-Trust Infrastructure via Terraform

## 1. プロジェクト概要
本プロジェクトは、Azure上に**ゼロトラスト・アーキテクチャ**の基本原則に基づいたセキュアなインフラを完全コード化（IaC）したものです。ネットワーク分離、ID管理、最小特権の原則を統合しています。

## 2. 実装されたゼロトラストの原則
- **明示的な検証**: Microsoft Entra IDによるユーザー・グループ管理。
- **最小特権アクセス**: RBAC（ロールベースのアクセス制御）を用い、外部パートナーグループに「閲覧者（Reader）」権限のみを付与。
- **ネットワークの分離**: 仮想ネットワーク（VNet）とNSG（ネットワークセキュリティグループ）による通信制御。

## 3. 技術スタック
- **IaC**: Terraform (v1.7.0)
- **Cloud**: Azure (azurerm, azuread プロバイダー)
- **CI/CD**: GitHubへのコード管理

## 4. 構築されたリソース
- **Network**: VNet, Subnet, NSG (HTTPS/443のみ許可)
- **IAM**: 
  - Entra ID User (External Partner)
  - Entra ID Group (Group-External-Partners)
  - Role Assignment (Reader権限の割り当て)

## 5. 解決した技術的課題
構築中、サービスプリンシパル（Terraform実行役）の権限不足による `403 Forbidden` エラーに直面しました。
- **原因**: `Contributor` ロールでは他者への権限割り当て（Role Assignment）が不可能であったこと。
- **対策**: サブスクリプション階層で一時的に `Owner` 権限をサービスプリンシパルに付与し、特権管理のフローを理解することで解決しました。
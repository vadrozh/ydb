---
title: "Обзор рецепта кода по установке режима выполнения транзакции в {{ ydb-short-name }}"
description: "В статье вы ознакомитесь как в разных SDK установить режим выполнения транзакции для выполнения запросов к {{ ydb-short-name }} ."
---

# Установка режима выполнения транзакции

Для выполнения запросов в {{ ydb-short-name }} SDK необходимо указывать [режим выполнения транзакции](../../../concepts/transactions.md#modes).

Ниже приведены примеры кода, которые используют встроенные в {{ ydb-short-name }} SDK средства создания объекта *режим выполнения транзакции*.

{% include [work in progress message](_includes/addition.md) %}

## Serializable {#serializable}

{% list tabs %}

- Go (native)

  ```go
  package main

  import (
    "context"
    "os"
    
    "github.com/ydb-platform/ydb-go-sdk/v3"
    "github.com/ydb-platform/ydb-go-sdk/v3/table"
  )

  func main() {
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()
    db, err := ydb.Open(ctx,
      os.Getenv("YDB_CONNECTION_STRING"),
      ydb.WithAccessTokenCredentials(os.Getenv("YDB_TOKEN")),
    )
    if err != nil {
      panic(err)
    }
    defer db.Close(ctx) 
    txControl := table.TxControl(
      table.BeginTx(table.WithSerializableReadWrite()),
      table.CommitTx(),
    )
    err := driver.Table().Do(scope.Ctx, func(ctx context.Context, s table.Session) error {
      _, _, err := s.Execute(ctx, txControl, "SELECT 1", nil)
      return err
    })
    if err != nil {
      fmt.Printf("unexpected error: %v", err)
    }
  }
  ```

{% endlist %}

## Online Read-Only {#online-read-only}

{% list tabs %}

- Go (native)

  ```go
  package main

  import (
    "context"
    "os"
    
    "github.com/ydb-platform/ydb-go-sdk/v3"
    "github.com/ydb-platform/ydb-go-sdk/v3/table"
  )

  func main() {
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()
    db, err := ydb.Open(ctx,
      os.Getenv("YDB_CONNECTION_STRING"),
      ydb.WithAccessTokenCredentials(os.Getenv("YDB_TOKEN")),
    )
    if err != nil {
      panic(err)
    }
    defer db.Close(ctx) 
    txControl := table.TxControl(
      table.BeginTx(table.WithOnlineReadOnly(table.WithInconsistentReads())),
      table.CommitTx(),
    )
    err := driver.Table().Do(scope.Ctx, func(ctx context.Context, s table.Session) error {
      _, _, err := s.Execute(ctx, txControl, "SELECT 1", nil)
      return err
    })
    if err != nil {
      fmt.Printf("unexpected error: %v", err)
    }
  }
  ```

{% endlist %}

## Stale Read-Only {#stale-read-only}

{% list tabs %}

- Go (native)

  ```go
  package main

  import (
    "context"
    "os"
    
    "github.com/ydb-platform/ydb-go-sdk/v3"
    "github.com/ydb-platform/ydb-go-sdk/v3/table"
  )

  func main() {
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()
    db, err := ydb.Open(ctx,
      os.Getenv("YDB_CONNECTION_STRING"),
      ydb.WithAccessTokenCredentials(os.Getenv("YDB_TOKEN")),
    )
    if err != nil {
      panic(err)
    }
    defer db.Close(ctx) 
    txControl := table.TxControl(
      table.BeginTx(table.WithStaleReadOnly()),
      table.CommitTx(),
    )
    err := driver.Table().Do(scope.Ctx, func(ctx context.Context, s table.Session) error {
      _, _, err := s.Execute(ctx, txControl, "SELECT 1", nil)
      return err
    })
    if err != nil {
      fmt.Printf("unexpected error: %v", err)
    }
  }
  ```

{% endlist %}

## Snapshot Read-Only {#snapshot-read-only}

{% list tabs %}

- Go (native)

  ```go
  package main

  import (
    "context"
    "os"
    
    "github.com/ydb-platform/ydb-go-sdk/v3"
    "github.com/ydb-platform/ydb-go-sdk/v3/table"
  )

  func main() {
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()
    db, err := ydb.Open(ctx,
      os.Getenv("YDB_CONNECTION_STRING"),
      ydb.WithAccessTokenCredentials(os.Getenv("YDB_TOKEN")),
    )
    if err != nil {
      panic(err)
    }
    defer db.Close(ctx) 
    txControl := table.TxControl(
      table.BeginTx(table.WithSnapshotReadOnly()),
      table.CommitTx(),
    )
    err := driver.Table().Do(scope.Ctx, func(ctx context.Context, s table.Session) error {
      _, _, err := s.Execute(ctx, txControl, "SELECT 1", nil)
      return err
    })
    if err != nil {
      fmt.Printf("unexpected error: %v", err)
    }
  }
  ```

{% endlist %}

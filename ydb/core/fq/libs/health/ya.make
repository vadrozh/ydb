LIBRARY()

SRCS(
    health.cpp
)

PEERDIR(
    library/cpp/actors/core
    ydb/core/fq/libs/shared_resources
    ydb/core/mon
    ydb/public/sdk/cpp/client/ydb_discovery
)

YQL_LAST_ABI_VERSION()

END()

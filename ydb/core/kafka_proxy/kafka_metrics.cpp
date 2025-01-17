#include "kafka_events.h"
#include "kafka_metrics.h"

namespace NKafka {

TVector<std::pair<TString, TString>> BuildLabels(const NKafka::TContext::TPtr context, const TString& method, const TString& topic, const TString& name, const TString& errorCode) {
    return {{"database", context->DatabasePath}, {"method", method}, {"cloud_id", context->CloudId},
            {"folder_id", context->FolderId}, {"database_id", context->DatabaseId},
            {"topic", topic}, {"errorCode", errorCode}, {"name", name}};
}

TActorId MakeKafkaMetricsServiceID() {
    static const char x[12] = "kafka_mtrcs";
    return TActorId(0, TStringBuf(x, 12));
}

} // namespace NKafka

#include "agent.h"
#include "owner.h"

namespace NKikimr::NColumnShard {

TValueAggregationAgent::TValueAggregationAgent(const TString& signalName, const TCommonCountersOwner& signalsOwner)
    : ValueSignalSum(signalsOwner.GetAggregationValue("SUM/" + signalName))
    , ValueSignalMin(signalsOwner.GetAggregationValue("MIN/" + signalName))
    , ValueSignalMax(signalsOwner.GetAggregationValue("MAX/" + signalName))
{

}

bool TValueAggregationAgent::CalcAggregationsAndClean(i64& sum, i64& minValue, i64& maxValue) const {
    if (Values.empty()) {
        return false;
    }
    sum = 0;
    minValue = Values.front()->GetValue();
    maxValue = Values.front()->GetValue();
    for (auto it = Values.begin(); it != Values.end();) {
        if (it->use_count() == 1) {
            it = Values.erase(it);
        } else {
            const i64 v = (*it)->GetValue();
            sum += v;
            if (minValue > v) {
                minValue = v;
            }
            if (maxValue < v) {
                maxValue = v;
            }
            ++it;
        }
    }
    return true;
}

std::optional<NKikimr::NColumnShard::TSignalAggregations> TValueAggregationAgent::GetAggregations() const {
    i64 sum;
    i64 min;
    i64 max;
    if (!CalcAggregationsAndClean(sum, min, max)) {
        return {};
    }
    return TSignalAggregations(sum, min, max);
}

void TValueAggregationAgent::ResendStatus() const {
    TGuard<TMutex> g(Mutex);
    std::optional<TSignalAggregations> aggr = GetAggregations();
    if (!!aggr) {
        ValueSignalMin->Set(aggr->Min);
        ValueSignalMax->Set(aggr->Max);
        ValueSignalSum->Set(aggr->Sum);
    } else {
        ValueSignalMin->Set(0);
        ValueSignalMax->Set(0);
        ValueSignalSum->Set(0);
    }
}

std::shared_ptr<NKikimr::NColumnShard::TValueAggregationClient> TValueAggregationAgent::GetClient() {
    TGuard<TMutex> g(Mutex);
    return *Values.emplace(Values.end(), std::make_shared<TValueAggregationClient>());
}

}

from processes.ultimate_question import UltimateQuestion
from processes.feature_count import FeatureCount
from processes.buffer import Buffer
from processes.jsonprocess import TestJson

list_of_processes = [
    FeatureCount(),
    UltimateQuestion(),
    Buffer(),
    TestJson()
]

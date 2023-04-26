from datetime import datetime
from utils.driver import DriverSetup
from model.test_case import TestCaseData
import json


class __FlutterReportGenerator:

    def __init__(self):
        self.time = datetime.now()
        self.testCaseData = []
        self.current_pointer = []

    def generate_report(self):
        report_generator_start = datetime.now()
        response = {
            "time": self.time,
            "capabilities": DriverSetup.capabilities,
            "result": self.__get_result()
        }
        report_generation_time = datetime.now() - report_generator_start
        duration = datetime.now() - self.time
        response["duration"] = str(duration.total_seconds() * 1000) + " ms"
        response["generatingReportTime"] = str(report_generation_time.total_seconds() * 1000) + " ms"

        # For now no screenshots
        file_name = DriverSetup.capabilities["automationName"] + "_" + self.time.strftime("%y_%m_%d_%H_%M_%S") + ".json"
        file_name = file_name.replace(" ", "_")
        file = open(DriverSetup.report_path + file_name, "a")
        file.write(json.dumps(response, default=str), )
        file.close()

    def __get_result(self):
        result = []
        print(len(self.testCaseData))
        for item in self.testCaseData:
            item: TestCaseData = item
            result.append(item.to_json())
        return result


report_generator = __FlutterReportGenerator()

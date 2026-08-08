from robot.api.deco import library, keyword

@library
class Test_Data:

    @keyword
    def get_input_data(self):
        data_map = {

            "Client Response Pending" : "Pending Requestor",
            "Return To Submitter": "In Progress"
        }

        return data_map


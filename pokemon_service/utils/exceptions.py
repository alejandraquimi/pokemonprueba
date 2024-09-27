from .output import output_ERROR


class GeneralException():
    def __init__(self, ex: Exception, func: str = None):
        self.exception = ex
        self.func = func

    def show_msg(self):
        output_ERROR(ex=self.exception, func=self.func)

    def show_file(self):
        print(self.exception.__traceback__.tb_frame.f_code.co_filename)

class CustomException(Exception):
    def __init__(self, message: str, func: str, status_code: int):
        super().__init__(message)
        self.status_code = status_code
        self.message = message
        self.func = func

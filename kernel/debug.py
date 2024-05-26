import gdb

# 创建一个新的GDB事件监听器
class FunctionCallLogger(gdb.Breakpoint):
    def __init__(self):
        super(FunctionCallLogger, self).__init__('(gdb)')  # Breakpoint at every function entry
        self.silent = True  # 设置断点为静默，不显示额外信息

    # 当事件发生时调用的函数
    def stop(self):
        # 获取当前的帧
        frame = gdb.selected_frame()
        # 获取函数名
        function_name = frame.name()
        if function_name:
            print("Function call: {}".format(function_name))
        return False  # 继续执行

# 在 GDB 初始化时自动运行脚本
def load_function_call_logger():
    FunctionCallLogger()
    print("Function Call Logger loaded and activated.")

# 注册脚本到GDB
gdb.events.exited.connect(load_function_call_logger)
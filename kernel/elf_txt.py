def save_elf_to_binary_text(input_file_path, output_file_path):
    try:
        # 打开二进制ELF文件和要写入的文本文件
        with open(input_file_path, 'rb') as bin_file, open(output_file_path, 'w') as text_file:
            # 读取整个文件内容
            byte_data = bin_file.read()
            # 转换每个字节为二进制字符串并写入文件
            for byte in byte_data:
                # 将每个字节转换成8位的二进制表示
                text_file.write(f"{byte:08b} ")
            text_file.write('\n')  # 可以在文件末尾加一个换行符
        print("ELF内容已保存到文本文件：", output_file_path)
    except Exception as e:
        print("处理过程中发生错误：", e)

# 使用示例
input_path = '../user/riscv64/fork'  # 输入文件路径
output_path = 'test.txt'  # 输出文本文件路径
save_elf_to_binary_text(input_path, output_path)

import argparse
import json
import yaml
import pandas as pd
import os
import glob
from pathlib import Path
import matplotlib.pyplot as plt


def load(path):

    with open(str(path), 'r') as f:
        return json.loads(f.read())

def convert_snake_to_title(snake_str):
    # Split the string by underscores and capitalize each part
    components = snake_str.split('_')
    # Join the components with a space and capitalize the first letter of each word
    title_str = ' '.join(x.title() for x in components)

    if snake_str == 'output_token_throughput':
        title_str += "(token/s)"
    else:
        title_str += "(ms)"

    return title_str

def main(args):

    # 获取目录中所有 JSON 文件的路径
    json_files = glob.glob(os.path.join(args.input_folder, '*.jsonl'))

    # 初始化一个空列表来存储所有 JSON 对象
    data = []

    # 逐个文件读取并解析 JSON 对象
    for file in json_files:
        with open(file, 'r') as f:
            for line in f:
                data.append(json.loads(line))

    # 将所有 JSON 对象转换成一个 DataFrame
    combined_df = pd.DataFrame(data)

    # 显示合并后的 DataFrame
    values = args.benchmark_item

    title_values = convert_snake_to_title(values)

    # 生成柱状对比图
    fig, ax = plt.subplots(figsize=(10, 6))

    # 合成索引名称
    combined_df['index_name'] = combined_df['dataset_name'] + '_ISL' + combined_df['random_input_len'].astype(str) + '_OSL' + combined_df['random_output_len'].astype(str)

    combined_df = combined_df.sort_values(by=['request_rate'])

    # 按照 dataset_name 进行绘图
    for name, group in combined_df.groupby('backend'):
        ax.plot(
            group['request_rate'],
            group[values],
            marker='o',
            label=name
        )

    # 添加标题和标签
    plt.title(f'Linear Plot of {title_values} by Backend Name')
    plt.xlabel('Dataset Name, Input Length and Output Length')
    plt.ylabel(title_values)

    # 旋转 x 轴刻度标签
    plt.xticks(rotation=0, ha='center')  # 45 度旋转，`ha='right'` 使标签右对齐

    # 显示图例
    plt.legend(title='Backend')
    
    # 保存图像到文件
    plt.tight_layout()
    plt.savefig(f'online/linear_plot_{values}.png')  # 这里设置你想要保存的文件名

    # 关闭图形
    plt.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analyze benchmark results")
    parser.add_argument("--input-folder", type=str, default="./online", help="Path to the results folder")
    parser.add_argument("--benchmark-item", type=str, default="benchmark_duration")

    args = parser.parse_args()
    main(args)
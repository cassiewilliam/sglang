import argparse
import json
import yaml
import pandas as pd
import os
import glob
from pathlib import Path

def load(path):

    with open(str(path), 'r') as f:
        return json.loads(f.read())

def main(args):

    # 获取目录中所有 JSON 文件的路径
    json_files = glob.glob(os.path.join(args.input_folder, '*.jsonl'))

    print(pd.read_json(json_files[0]))

    # 使用列表推导式读取所有 JSON 文件，并创建 DataFrame 列表
    dfs = [pd.read_json(file) for file in json_files]

    # 将所有 DataFrame 合并成一个
    combined_df = pd.concat(dfs, ignore_index=True)

    # 显示合并后的 DataFrame
    print(combined_df)

    

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analyze benchmark results")
    parser.add_argument("--input-folder", type=str, default="./offline", help="Path to the results folder")
    parser.add_argument("--output-file", type=str, default="offline_benchmark.yaml")

    args = parser.parse_args()
    main(args)
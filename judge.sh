#!/bin/bash

echo "請輸入您要檢測的關卡"
read level
echo "請輸入您的正則表達式"
read regex

testcases_dir="testcase"

while IFS= read -r line; do
    line=$(echo -n "$line" | tr -d '\n')
    if [[ -n "$line" && ! $(echo "$line" | grep -E "$regex") ]]; then
        echo "Failed accept testcase: $line"
        exit 1
    fi
done < "$testcases_dir/$level.accept"


while IFS= read -r line; do
    line=$(echo -n "$line" | tr -d '\n')
    if [[ -n "$line" && $(echo "$line" | grep -E "$regex") ]]; then
        echo "Failed reject testcase: $line"
        exit 1
    fi
done < "$testcases_dir/$level.reject"

echo "All testcases passed"
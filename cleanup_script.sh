#!/bin/bash

# ==========================================
# 城市可达性分析项目清理脚本
# ==========================================
# 用途: 清理临时文件、系统文件和重新整理输出文件
# 使用方法: bash cleanup_script.sh
# ==========================================

echo "🚀 开始清理项目..."

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 计数器
DELETED_COUNT=0
MOVED_COUNT=0

# ==========================================
# 1. 删除系统文件
# ==========================================
echo -e "\n${YELLOW}[1/4] 清理系统文件...${NC}"

# 删除 .DS_Store 文件
DS_STORE_COUNT=$(find . -name ".DS_Store" 2>/dev/null | wc -l)
if [ $DS_STORE_COUNT -gt 0 ]; then
    find . -name ".DS_Store" -delete 2>/dev/null
    echo -e "${GREEN}✓ 删除了 $DS_STORE_COUNT 个 .DS_Store 文件${NC}"
    DELETED_COUNT=$((DELETED_COUNT + DS_STORE_COUNT))
else
    echo "  没有找到 .DS_Store 文件"
fi

# 删除 Thumbs.db (Windows)
THUMBS_COUNT=$(find . -name "Thumbs.db" 2>/dev/null | wc -l)
if [ $THUMBS_COUNT -gt 0 ]; then
    find . -name "Thumbs.db" -delete 2>/dev/null
    echo -e "${GREEN}✓ 删除了 $THUMBS_COUNT 个 Thumbs.db 文件${NC}"
    DELETED_COUNT=$((DELETED_COUNT + THUMBS_COUNT))
fi

# 删除临时 Office 文件
TEMP_OFFICE_COUNT=$(find . -name "~\$*" 2>/dev/null | wc -l)
if [ $TEMP_OFFICE_COUNT -gt 0 ]; then
    find . -name "~\$*" -delete 2>/dev/null
    echo -e "${GREEN}✓ 删除了 $TEMP_OFFICE_COUNT 个临时 Office 文件${NC}"
    DELETED_COUNT=$((DELETED_COUNT + TEMP_OFFICE_COUNT))
fi

# ==========================================
# 2. 检查并创建 outputs 文件夹
# ==========================================
echo -e "\n${YELLOW}[2/4] 检查输出文件夹结构...${NC}"

if [ ! -d "outputs" ]; then
    mkdir -p outputs/pptx outputs/plots
    echo -e "${GREEN}✓ 创建了 outputs 文件夹${NC}"
else
    echo "  outputs 文件夹已存在"
    mkdir -p outputs/pptx outputs/plots
fi

# ==========================================
# 3. 移动散落的 PPTX 文件
# ==========================================
echo -e "\n${YELLOW}[3/4] 整理 PPTX 文件...${NC}"

# 查找不在 outputs 文件夹中的 pptx 文件
PPTX_FILES=$(find . -name "*.pptx" -not -path "./outputs/*" -type f 2>/dev/null)

if [ ! -z "$PPTX_FILES" ]; then
    while IFS= read -r file; do
        if [ ! "$file" == "./outputs/pptx/"* ]; then
            filename=$(basename "$file")
            mv "$file" "outputs/pptx/" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ 移动: $filename${NC}"
                MOVED_COUNT=$((MOVED_COUNT + 1))
            fi
        fi
    done <<< "$PPTX_FILES"
    echo -e "${GREEN}✓ 移动了 $MOVED_COUNT 个 PPTX 文件${NC}"
else
    echo "  没有找到需要移动的 PPTX 文件"
fi

# ==========================================
# 4. 检查 .gitignore
# ==========================================
echo -e "\n${YELLOW}[4/4] 检查 .gitignore 文件...${NC}"

if [ ! -f ".gitignore" ]; then
    echo -e "${RED}✗ 警告: .gitignore 文件不存在！${NC}"
    echo "  建议创建 .gitignore 文件以排除大文件"
else
    echo -e "${GREEN}✓ .gitignore 文件存在${NC}"

    # 检查关键排除规则
    if grep -q "outputs/" ".gitignore"; then
        echo "  ✓ outputs/ 已被排除"
    else
        echo -e "${YELLOW}  ! 建议在 .gitignore 中添加 outputs/${NC}"
    fi

    if grep -q "*.rds" ".gitignore" || grep -q "*.rda" ".gitignore"; then
        echo "  ✓ R 数据文件已被排除"
    else
        echo -e "${YELLOW}  ! 建议在 .gitignore 中添加 *.rds 和 *.rda${NC}"
    fi

    if grep -q "*.dbf" ".gitignore" || grep -q "*.shp" ".gitignore"; then
        echo "  ✓ 地理信息文件已被排除"
    else
        echo -e "${YELLOW}  ! 建议在 .gitignore 中添加地理信息文件扩展名${NC}"
    fi
fi

# ==========================================
# 5. 生成清理报告
# ==========================================
echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}清理完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "删除文件数: ${DELETED_COUNT}"
echo -e "移动文件数: ${MOVED_COUNT}"
echo ""

# 显示项目大小
echo -e "${YELLOW}当前项目大小：${NC}"
du -sh . 2>/dev/null | awk '{print "  总大小: " $1}'
du -sh data/ 2>/dev/null | awk '{print "  data/: " $1}'
du -sh outputs/ 2>/dev/null | awk '{print "  outputs/: " $1}'

echo ""
echo -e "${YELLOW}提示:${NC}"
echo "  - outputs/ 文件夹不会上传到 GitHub"
echo "  - data/ 文件夹中的大文件已被 .gitignore 排除"
echo "  - 使用 'git status' 检查待提交的文件"
echo ""
echo -e "${GREEN}✓ 项目已准备好上传到 GitHub！${NC}"

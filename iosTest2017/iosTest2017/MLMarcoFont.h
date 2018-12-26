//
//  MLMarcoFont.h
//  Mateline
//
//  Created by yangzijiang on 2018/12/22.
//  字体

#ifndef MLMarcoFont_h
#define MLMarcoFont_h

#define ML_FONT_SIZE(size) [UIFont systemFontOfSize:(size)]

#pragma mark - 2018H2新需求
// H1 一级标题 大标题
#define font_size_h1_title ML_FONT_SIZE(20)
// H2 二级标题 页面导航栏标题
#define font_size_h2_title ML_FONT_SIZE(18)
// Subtitle 子标题 对话框标题、Bottom Sheet、Section分类标题 | Medium
#define font_size_sub_title ML_FONT_SIZE(16)
// Body 正文 正文
#define font_size_body ML_FONT_SIZE(14)
// BUTTON 按钮 按钮文字 | Medium | All Caps
#define font_size_button ML_FONT_SIZE(16)
// Caption 描述信息 描述信息
#define font_size_caption ML_FONT_SIZE(12)
// Overline 辅助信息 辅助类信息文字 | All Caps
#define font_size_over_line ML_FONT_SIZE(10)

#endif /* MLMarcoFont_h */

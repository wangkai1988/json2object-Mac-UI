# json2object Mac UI

## 介绍

本项目是Mac系统上的UI工具，用于通过json数据快速生成iOS第三方json库所需的模型文件（Objective-C的.h .m文件）

## 支持的第三方库

### MJExtension
convert json string to MJExtension class declaration

https://github.com/CoderMJLee/MJExtension


### JSONModel
convert json string to JSONModel class declaration

https://github.com/icanzilb/JSONModel


### YYModel
convert json string to YYModel class declaration

https://github.com/ibireme/YYModel


## 使用步骤

### 1.调整 “文本编辑.app”。
 
在MacOSX上打开”文本编辑.app”， 选择”偏好设置”， 在”格式”中将 “多信息文本” 改为”纯文本”。（此时若新建一个纯文本文件，后缀名应该会是txt）

### 2.编辑json文件。

将接口获取的json数据放入刚才新建的纯文本文件中。最好用在线校验网站，如[Be JSON](http://www.bejson.com)进行整理校验，如下
```
{
    "errorcode": 1,
    "error": "获取成功",
    "data": [
        {
            "id": "2",
            "user_name": "哈哈",
            "user_id": "1",
            "title": “标题1”,
            "content": “内容1”,
            "ip": null
        },
        {
            "id": "1",
            "user_name": "张三",
            "user_id": “2”,
            "title": “标题2”,
            "content": “内容2”,
            "ip": "123.233.242.74"
        }
    ]
}
```

### 3.选择刚才编辑的json文件地址并填写对应的Object基类名称。

例如获取用户列表，基类名可填写UserListModel。

### 4.点击“生成文件”按钮。

成功会打开文件所在文件夹，失败会给出报错提示。


## 作者

wangkai1988

### 核心python文件来自于
dofork(https://github.com/dofork/json2object)
lanjing99(https://github.com/lanjing99/json2object)



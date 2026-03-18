import router from '@ohos.router';

interface NavItem {
  title: string;
  subtitle: string;
  url: string;
}

@Entry
@Component
struct Index {
  private items: Array<NavItem> = [
    {
      title: '鸿蒙-1. 组件基础',
      subtitle: 'Text / Button / Input / Toggle / Slider / List / Image',
      url: 'pages/ComponentBasics'
    },
    {
      title: '鸿蒙-2. 知乎评论',
      subtitle: '评论列表、点赞、回复、层级展示',
      url: 'pages/ZhihuComment'
    },
    {
      title: '鸿蒙-3. 状态管理',
      subtitle: '@State / @Prop / @Link / AppStorage',
      url: 'pages/StateManagement'
    },
    {
      title: '鸿蒙-4. 美团外卖',
      subtitle: '搜索、分类、店铺卡片、加入购物车',
      url: 'pages/MeituanWaimai'
    },
    {
      title: '鸿蒙-5. 应用程序开发',
      subtitle: '路由、表单校验、提示、设置持久化',
      url: 'pages/AppDev'
    },
    {
      title: '鸿蒙-6. 华为闹钟',
      subtitle: '当前时间、闹钟列表、开关、添加闹钟',
      url: 'pages/HuaweiClock'
    }
  ];

  build() {
    Column() {
      Text('鸿蒙示例项目')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 4 })

      Text('点击进入对应主题，查看功能点展示与示例代码')
        .fontSize(12)
        .fontColor('#666666')
        .margin({ bottom: 16 })

      List() {
        ForEach(this.items, (item: NavItem) => {
          ListItem() {
            Row() {
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#111111')
                Text(item.subtitle)
                  .fontSize(12)
                  .fontColor('#7A7A7A')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#B0B0B0')
            }
            .padding(14)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .margin({ bottom: 12 })
          .onClick(() => {
            router.pushUrl({ url: item.url });
          })
        }, (item: NavItem) => item.url)
      }
      .width('100%')
    }
    .padding(16)
    .height('100%')
    .width('100%')
    .backgroundColor('#F4F6F8')
  }
}

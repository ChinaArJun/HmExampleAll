import router from '@ohos.router';

@Entry
@Component
struct RouteDemo {
  build() {
    Column() {
      Row() {
        Text('返回')
          .fontSize(14)
          .fontColor('#3B6EF5')
          .padding({ right: 12 })
          .onClick(() => {
            router.back();
          })
        Text('路由示例页')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .margin({ bottom: 16 })

      Text('这是一个独立页面，用于展示 router.pushUrl 的效果。')
        .fontSize(14)
        .fontColor('#333333')
        .margin({ bottom: 12 })

      Button('返回上一页')
        .onClick(() => {
          router.back();
        })
    }
    .padding(16)
    .height('100%')
    .width('100%')
    .backgroundColor('#F4F6F8')
  }
}

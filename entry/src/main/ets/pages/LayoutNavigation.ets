import router from '@ohos.router';

interface GridCard {
  title: string;
  desc: string;
  color: string;
}

@Component
struct PageHeader {
  @Prop title: string;

  build() {
    Row() {
      Text('返回')
        .fontSize(14)
        .fontColor('#3B6EF5')
        .padding({ right: 12 })
        .onClick(() => {
          router.back();
        })
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .padding({ bottom: 12 })
  }
}

@Component
struct CodeBlock {
  @Prop code: string;

  build() {
    Text(this.code)
      .fontSize(12)
      .fontFamily('monospace')
      .fontColor('#1F2A44')
      .lineHeight(18)
      .padding(12)
      .backgroundColor('#EEF3FF')
      .borderRadius(8)
      .width('100%')
  }
}

@Entry
@Component
struct LayoutNavigation {
  @State tabsIndex: number = 0;
  @State swiperIndex: number = 0;

  private gridCards: Array<GridCard> = [
    { title: 'Grid 01', desc: '快速入口', color: '#E8F0FF' },
    { title: 'Grid 02', desc: '内容推荐', color: '#FFF2E5' },
    { title: 'Grid 03', desc: '任务清单', color: '#E9F7EF' },
    { title: 'Grid 04', desc: '统计概览', color: '#F3E8FF' },
    { title: 'Grid 05', desc: '消息中心', color: '#FFEFF1' },
    { title: 'Grid 06', desc: '设置管理', color: '#EFF7FF' }
  ];

  private tabsCode: string = `Tabs({ index: this.tabsIndex }) {
  TabContent() { Text('概览内容') }.tabBar('概览')
  TabContent() { Text('分析内容') }.tabBar('分析')
}
.onChange((index: number) => {
  this.tabsIndex = index;
})`;

  private swiperCode: string = `Swiper() {
  Text('Banner A')
  Text('Banner B')
}
.autoPlay(true)
.indicator(true)
.interval(2500)`;

  private gridCode: string = `Grid() {
  GridItem() { Text('卡片 1') }
  GridItem() { Text('卡片 2') }
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '布局与导航' })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页展示 Tabs、Swiper、Grid 等容器组件的常见组合方式。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('Tabs 内容切换')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Tabs({ index: this.tabsIndex }) {
            TabContent() {
              Column() {
                Text('概览内容')
                  .fontSize(14)
                Text('查看核心数据与进度')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .padding(12)
            }
            .tabBar('概览')

            TabContent() {
              Column() {
                Text('分析内容')
                  .fontSize(14)
                Text('趋势分析与指标对比')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .padding(12)
            }
            .tabBar('分析')

            TabContent() {
              Column() {
                Text('协作内容')
                  .fontSize(14)
                Text('成员动态与任务协作')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .padding(12)
            }
            .tabBar('协作')
          }
          .barMode(BarMode.Fixed)
          .onChange((index: number) => {
            this.tabsIndex = index;
          })
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.tabsCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('Swiper 轮播')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Swiper() {
            ForEach(['Banner A', 'Banner B', 'Banner C'], (title: string) => {
              Column() {
                Text(title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Text('滑动查看更多内容')
                  .fontSize(12)
                  .fontColor('#666666')
              }
              .width('100%')
              .height(120)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor('#EEF3FF')
              .borderRadius(12)
            }, (title: string) => title)
          }
          .autoPlay(true)
          .indicator(true)
          .interval(2500)
          .loop(true)
          .itemSpace(12)
          .onChange((index: number) => {
            this.swiperIndex = index;
          })
          .margin({ bottom: 8 })

          Text(`当前索引: ${this.swiperIndex}`)
            .fontSize(12)
            .fontColor('#666666')
            .margin({ bottom: 12 })

          CodeBlock({ code: this.swiperCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('Grid 卡片布局')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Grid() {
            ForEach(this.gridCards, (card: GridCard) => {
              GridItem() {
                Column() {
                  Text(card.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text(card.desc)
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ top: 4 })
                }
                .padding(12)
                .borderRadius(12)
                .backgroundColor(card.color)
              }
            }, (card: GridCard) => card.title)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .height(240)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.gridCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 16 })
      }
      .padding(16)
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

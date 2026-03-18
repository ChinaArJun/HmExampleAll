import router from '@ohos.router';

@Component
struct PageHeader {
  @Prop title: string;
  @Prop cartCount: number;

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
        .layoutWeight(1)
      Text(`购物车 ${this.cartCount}`)
        .fontSize(12)
        .fontColor('#FF6A00')
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

interface Category {
  name: string;
}

interface Store {
  id: string;
  name: string;
  rating: string;
  distance: string;
  delivery: string;
  price: string;
  tag: string;
}

@Entry
@Component
struct MeituanWaimai {
  @State cartCount: number = 0;
  @State selectedCategory: string = '推荐';
  @State keyword: string = '';

  private categories: Array<Category> = [
    { name: '推荐' },
    { name: '快餐便当' },
    { name: '奶茶咖啡' },
    { name: '小吃夜宵' },
    { name: '水果' },
    { name: '品质精选' }
  ];

  private stores: Array<Store> = [
    {
      id: 's1',
      name: '上班族便当',
      rating: '4.8',
      distance: '1.2km',
      delivery: '30分钟',
      price: '人均¥28',
      tag: '满30减10'
    },
    {
      id: 's2',
      name: '茶多多',
      rating: '4.7',
      distance: '900m',
      delivery: '25分钟',
      price: '人均¥18',
      tag: '第二杯半价'
    },
    {
      id: 's3',
      name: '深夜烧烤',
      rating: '4.6',
      distance: '2.3km',
      delivery: '40分钟',
      price: '人均¥45',
      tag: '夜宵专享'
    }
  ];

  private listCode: string = `ForEach(this.stores, (store: Store) => {\n  Row() {\n    Text(store.name)\n    Button('加入')\n      .onClick(() => this.cartCount += 1)\n  }\n})`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '美团外卖', cartCount: this.cartCount })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页模拟外卖首页的关键结构：搜索框、横向分类、商家卡片与“加入购物车”交互。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
            .margin({ bottom: 4 })
          Text('• 搜索框：输入关键字，预留搜索联动能力')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 分类条：横向滚动标签，点击切换选中态')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 商家卡片：评分/距离/配送/优惠信息的布局组合')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 购物车计数：按钮点击累加，演示状态更新')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          TextInput({ text: this.keyword, placeholder: '搜索商家或商品' })
            .height(40)
            .padding({ left: 10 })
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .border({ width: 1, color: '#E0E0E0' })
            .onChange((value: string) => {
              this.keyword = value;
            })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('分类')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Scroll() {
            Row() {
              ForEach(this.categories, (item: Category) => {
                Text(item.name)
                  .fontSize(12)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor(this.selectedCategory === item.name ? '#FF6A00' : '#F1F2F4')
                  .fontColor(this.selectedCategory === item.name ? '#FFFFFF' : '#333333')
                  .borderRadius(16)
                  .margin({ right: 8 })
                  .onClick(() => {
                    this.selectedCategory = item.name;
                  })
              }, (item: Category) => item.name)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('附近商家')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })

          Column() {
            ForEach(this.stores, (store: Store) => {
              Column() {
                Row() {
                  Column() {
                    Text(store.name)
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                    Text(`${store.rating}分 · ${store.distance} · ${store.delivery}`)
                      .fontSize(12)
                      .fontColor('#666666')
                      .margin({ top: 4 })
                    Text(store.price)
                      .fontSize(12)
                      .fontColor('#666666')
                      .margin({ top: 2 })
                  }
                  .layoutWeight(1)
                  Button('加入')
                    .fontSize(12)
                    .height(28)
                    .backgroundColor('#FF6A00')
                    .fontColor('#FFFFFF')
                    .onClick(() => {
                      this.cartCount += 1;
                    })
                }
                Text(store.tag)
                  .fontSize(11)
                  .fontColor('#FF6A00')
                  .margin({ top: 6 })
              }
              .padding(12)
              .backgroundColor('#F7F8FA')
              .borderRadius(10)
              .margin({ bottom: 10 })
            }, (store: Store) => store.id)
          }
          .margin({ bottom: 12 })

          CodeBlock({ code: this.listCode })
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

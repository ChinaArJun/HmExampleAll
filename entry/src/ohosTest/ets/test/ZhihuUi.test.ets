import { describe, it, expect } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Driver, ON } from '@ohos.UiTest';
import Want from '@ohos.app.ability.Want';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const args = abilityDelegatorRegistry.getArguments();
const bundleName: string = args.bundleName ?? '';

export default function zhihuUiTest() {
  describe('ZhihuCommentUiTest', () => {
    it('should toggle like button', 0, async (done: Function) => {
      const want: Want = { bundleName: bundleName, abilityName: 'EntryAbility' };
      await delegator.startAbility(want);

      const driver = Driver.create();
      await driver.assertComponentExist(ON.text('鸿蒙示例项目'));

      const nav = await driver.findComponent(ON.id('navZhihu'));
      await nav.click();
      await driver.assertComponentExist(ON.text('知乎评论'));

      const likeBtn = await driver.findComponent(ON.text('点赞'));
      await likeBtn.click();
      await driver.assertComponentExist(ON.text('已赞'));

      done();
    });
  });
}

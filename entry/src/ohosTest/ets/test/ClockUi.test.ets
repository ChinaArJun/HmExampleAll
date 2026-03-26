import { describe, it } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Driver, ON } from '@ohos.UiTest';
import Want from '@ohos.app.ability.Want';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const args = abilityDelegatorRegistry.getArguments();
const bundleName: string = args.bundleName ?? '';

export default function clockUiTest() {
  describe('HuaweiClockUiTest', () => {
    it('should add alarm item', 0, async (done: Function) => {
      const want: Want = { bundleName: bundleName, abilityName: 'EntryAbility' };
      await delegator.startAbility(want);

      const driver = Driver.create();
      await driver.assertComponentExist(ON.text('鸿蒙示例项目'));

      const nav = await driver.findComponent(ON.id('navClock'));
      await nav.click();
      await driver.assertComponentExist(ON.text('华为闹钟'));

      const addBtn = await driver.findComponent(ON.text('新增闹钟'));
      await addBtn.click();
      await driver.assertComponentExist(ON.text('新闹钟'));

      done();
    });
  });
}

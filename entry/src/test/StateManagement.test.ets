import { describe, it, expect } from '@ohos/hypium';
import { appendExclamation, formatAutoSyncLabel, updateCount } from '../main/ets/utils/StateHelpers';

export default function stateManagementTest() {
  describe('StateHelpers', () => {
    it('updateCount should apply delta', 0, () => {
      expect(updateCount(1, 2)).assertEqual(3);
      expect(updateCount(0, -1)).assertEqual(-1);
    });

    it('appendExclamation should add suffix', 0, () => {
      expect(appendExclamation('状态提升')).assertEqual('状态提升!');
    });

    it('formatAutoSyncLabel should match state', 0, () => {
      expect(formatAutoSyncLabel(true)).assertEqual('自动同步开启');
      expect(formatAutoSyncLabel(false)).assertEqual('自动同步关闭');
    });
  });
}

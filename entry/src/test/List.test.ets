import localUnitTest from './LocalUnit.test';
import stateManagementTest from './StateManagement.test';

export default function testsuite() {
  localUnitTest();
  stateManagementTest();
}

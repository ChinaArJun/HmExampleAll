export function updateCount(current: number, delta: number): number {
  return current + delta;
}

export function appendExclamation(message: string): string {
  return `${message}!`;
}

export function formatAutoSyncLabel(autoSync: boolean): string {
  return autoSync ? '自动同步开启' : '自动同步关闭';
}

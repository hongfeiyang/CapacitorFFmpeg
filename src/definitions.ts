declare module '@capacitor/core' {
  interface PluginRegistry {
    FFmpeg: FFmpegPlugin;
  }
}

export interface FFmpegPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  exec(command: string): Promise<{ value: string }>;
}

import { WebPlugin } from '@capacitor/core';
import { FFmpegPlugin } from './definitions';

export class FFmpegWeb extends WebPlugin implements FFmpegPlugin {
  constructor() {
    super({
      name: 'FFmpeg',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async exec(command: string): Promise<{ value: string }> {
    return {
      value: command
    };
  }
}

const FFmpeg = new FFmpegWeb();

export { FFmpeg };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(FFmpeg);

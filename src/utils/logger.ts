import { Logger as AzureLogger } from '@dvsa/azure-logger';
import config from '../config/index';

export class Logger extends AzureLogger {
  constructor() {
    super('FTTS', config.websiteSiteName);
  }
}

export enum BusinessTelemetryEvent {
  // API
  TDM_PROVISION_CALLED = 'TDM_PROVISION_CALLED',
  TDM_RESERVE_CALLED = 'TDM_RESERVE_CALLED',
  TDM_RETRIEVE_CALLED = 'TDM_RETRIEVE_CALLED',

  TDM_NOT_WHITELISTED_URL_CALL = 'NOT_WHITELISTED_URL_CALL',
}

export const logger = new Logger();

import { InternalAccessDeniedError, Address } from '@dvsa/egress-filtering';

import { logger, BusinessTelemetryEvent } from '../utils/logger';

export const whitelistedUrls: Address[] = [];

export const internalAccessDeniedError = (error: InternalAccessDeniedError): void => {
  logger.security(BusinessTelemetryEvent.TDM_NOT_WHITELISTED_URL_CALL, {
    host: error.host,
    port: error.port,
    reason: JSON.stringify(error),
  });
  logger.event(BusinessTelemetryEvent.TDM_NOT_WHITELISTED_URL_CALL, error.message, {
    host: error.host,
    port: error.port,
    reason: JSON.stringify(error),
  });
};

import { AzureFunction, Context, HttpRequest } from '@azure/functions';
import { httpTriggerContextWrapper } from '@dvsa/azure-logger';
import { withEgressFiltering } from '@dvsa/egress-filtering';
import { internalAccessDeniedError, whitelistedUrls } from '../../services/egress-filter';
import { BusinessTelemetryEvent, logger } from '../../utils/logger';

// eslint-disable-next-line @typescript-eslint/no-unused-vars,@typescript-eslint/require-await
export const httpTrigger: AzureFunction = async (context: Context): Promise<void> => {
  logger.event(BusinessTelemetryEvent.TDM_RETRIEVE_CALLED);
};

export const index = async (context: Context, httpRequest: HttpRequest): Promise<void> => httpTriggerContextWrapper(
  withEgressFiltering(httpTrigger, whitelistedUrls, internalAccessDeniedError, logger),
  context,
  httpRequest,
);

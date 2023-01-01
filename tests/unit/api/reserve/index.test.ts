import { Context, HttpRequest } from '@azure/functions';
import { mockedLogger } from '../../../mocks/logger.mock';
import { httpTrigger } from '../../../../src/api/reserve';
import { BusinessTelemetryEvent } from '../../../../src/utils/logger';

describe('When reserve httpTrigger is called', () => {
  test('Logger should log out event', async () => {
    await httpTrigger({} as Context, {} as HttpRequest);

    expect(mockedLogger.event).toHaveBeenCalledWith(BusinessTelemetryEvent.TDM_RESERVE_CALLED);
  });
});

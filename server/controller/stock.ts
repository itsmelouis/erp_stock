import { H3Event } from 'h3';

import * as stockModel from '~~/server/model/stock';

export const readAllProductStock = async () => {
  try {
    const result = await stockModel.readAllProductStock();

    return {
      data: result
    };
  } catch (err) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Something went wrong'
    });
  }
};

export const read = async (evt: H3Event) => {
  try {
    const result = await stockModel.read(evt.context.params?.id as string);

    return {
      data: result
    };
  } catch {
    throw createError({
      statusCode: 500,
      statusMessage: 'Something went wrong'
    });
  }
};

export const readTotalStock = async () => {
  try {
    const result = await stockModel.readTotalStock();

    return {
      data: result
    };
  } catch (err) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Something went wrong'
    });
  }
}

export const update = async (evt: H3Event) => {
  try {
    const body = await readBody(evt);
    const result = await stockModel.update(evt.context.params?.id as string, {
      quantite_dispo_Stock: body.amount
    });

    return {
      data: result
    };
  } catch {
    throw createError({
      statusCode: 500,
      statusMessage: 'Something went wrong'
    });
  }
};

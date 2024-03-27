import { H3Event } from 'h3';

import * as productModel from '~~/server/model/product';

export const create = async (evt: H3Event) => {
  try {
    const body = await readBody(evt);
    const result = await productModel.create({
      name: body.name,
      description: body.description,
      unitPrice: body.unitPrice,
      idCategory: body.idCategory,
      idStock: body.idStock
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

export const readAll = async () => {
  try {
    const result = await productModel.readAll();

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
    const result = await productModel.read(evt.context.params?.id as string);

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

export const update = async (evt: H3Event) => {
  try {
    const body = await readBody(evt);
    const result = await productModel.update(evt.context.params?.id as string, {
      name: body.name,
      description: body.description,
      unitPrice: body.unitPrice
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

export const remove = async (evt: H3Event) => {
  try {
    const result = await productModel.remove(evt.context.params?.id as string);

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

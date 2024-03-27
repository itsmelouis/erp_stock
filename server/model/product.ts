import { sql } from '~~/server/db';

export type ProductModel = {
  id: string;
  name: string;
  description: string;
  unitPrice: number;
  idCategory: string;
  idStock: string;
};

export const create = async (data: Omit<ProductModel, "id">) => {
  const result = await sql({
    query: 'CALL createProduit(?, ?, ?, ?, ?)',
    values: [data.name, data.description, data.unitPrice, data.idCategory, data.idStock]
  }) as any;

  return result as ProductModel[];
};

export const read = async (id: string) => {
  const [result,] = (await sql({
    query: `CALL getProduit(?)`,
    values: [id]
  })) as any;
  return result.length === 1 ? (result[0] as ProductModel) : null;
};

export const readAll = async () => {
  const result = await sql({
    query: 'CALL getAllProduits()'
  });

  return result as ProductModel[];
};

export const update = async (id: string, data: Pick<ProductModel, 'description' | 'name' | 'unitPrice'>) => {
  await sql({
    query: `CALL updateProduit(?, ?, ?, ?)`,
    values: [id, data.name, data.description, data.unitPrice]
  });

  return await read(id);
};

export const remove = async (id: string) => {
  await sql({
    query: 'CALL deleteProduit(?)',
    values: [id]
  });

  return true;
};

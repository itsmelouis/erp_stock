import { sql } from '~~/server/db';

export type CategoryModel = {
  id: string;
  name: string;
};

export const create = async (data: Omit<CategoryModel, "id">) => {
  const result = await sql({
    query: 'CALL createCategorie(?)',
    values: [data.name]
  }) as any;

  return result as CategoryModel[];
};

export const read = async (id: string) => {
  const [result,] = (await sql({
    query: `CALL getCategorie(?)`,
    values: [id]
  })) as any;
  return result.length === 1 ? (result[0] as CategoryModel) : null;
};

export const readAll = async () => {
  const result = await sql({
    query: 'CALL getAllCategories()'
  });

  return result as CategoryModel[];
};

export const update = async (id: string, data: Omit<CategoryModel, "id">) => {
  await sql({
    query: `CALL updateCategorie(?, ?)`,
    values: [id, data.name]
  });

  return await read(id);
};

export const remove = async (id: string) => {
  await sql({
    query: 'CALL deleteCategorie(?)',
    values: [id]
  });

  return true;
};

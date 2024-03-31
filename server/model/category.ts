import { sql } from '~~/server/db';

export type CategoryModel = {
  id_Categorie: string;
  nom_Categorie: string;
};

export const create = async (data: Omit<CategoryModel, "id_Categorie">) => {
  const result = await sql({
    query: 'CALL createCategorie(?)',
    values: [data.nom_Categorie]
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

export const update = async (id: string, data: Omit<CategoryModel, "id_Categorie">) => {
  await sql({
    query: `CALL updateCategorie(?, ?)`,
    values: [id, data.nom_Categorie]
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

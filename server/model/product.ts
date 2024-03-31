import { sql } from '~~/server/db';

export type ProductModel = {
  id_Produit: string;
  nom_Produit: string;
  description_Produit: string;
  prix_unitaire_Produit: number;
  id_Categorie: string;
  id_Stock: string;
  quantite_dispo_Stock?: number;
  nom_Categorie?: string;
};

export const create = async (data: Omit<ProductModel, "id_Produit" | "id_Stock">) => {
  const result = await sql({
    query: 'CALL createProduit(?, ?, ?, ?, ?)',
    values: [data.nom_Produit, data.description_Produit, data.prix_unitaire_Produit, data.id_Categorie, data.quantite_dispo_Stock]
  }) as any;

  return result as ProductModel[];
};

export const read = async (id_Produit: string) => {
  const [result,] = (await sql({
    query: `CALL getProduit(?)`,
    values: [id_Produit]
  })) as any;
  return result.length === 1 ? (result[0] as ProductModel) : null;
};

export const readAll = async () => {
  const result = await sql({
    query: 'CALL getAllProduits()'
  });

  return result as ProductModel[];
};

export const update = async (id_Produit: string, data: Pick<ProductModel, 'description_Produit' | 'nom_Produit' | 'prix_unitaire_Produit'>) => {
  await sql({
    query: `CALL updateProduit(?, ?, ?, ?)`,
    values: [id_Produit, data.nom_Produit, data.description_Produit, data.prix_unitaire_Produit]
  });

  return await read(id_Produit);
};

export const remove = async (id_Produit: string) => {
  await sql({
    query: 'CALL deleteProduit(?)',
    values: [id_Produit]
  });

  return true;
};

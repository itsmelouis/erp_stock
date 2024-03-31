import { sql } from '~~/server/db';

export type StockModel = {
  id_Stock: string;
  quantite_dispo_Stock: number;
  date_entree_Stock: Date;
  date_sortie_Stock: Date | null;
};
export type TotalStockModel = {
  id_Stock_total: string;
  total_Stock_total: number;
};


export const read = async (id: string) => {
  const [result,] = (await sql({
    query: `CALL getProduitStock(?)`,
    values: [id]
  })) as any;
  return result.length === 1 ? (result[0] as StockModel) : null;
};

export const readAllProductStock = async () => {
  const result = await sql({
    query: 'CALL getAllProduitStock()'
  });

  return result as StockModel[];
};

export const readTotalStock = async () => {
  const [result,] = (await sql({
    query: 'CALL getTotalStock()'
  })) as any;
  return result.length === 1 ? (result[0] as TotalStockModel) : null;
}

export const update = async (id: string, data: Pick<StockModel, "quantite_dispo_Stock">) => {
  await sql({
    query: `CALL updateProduitStock(?, ?)`,
    values: [id, data.quantite_dispo_Stock]
  });

  return await read(id);
};

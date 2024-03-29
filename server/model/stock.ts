import { sql } from '~~/server/db';

export type StockModel = {
  id: string;
  amount: number;
  dateEntry: Date;
  dateExit: Date | null;
};

export type TotalStockModel = {
  id: string;
  amount: number;
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
  const result = await sql({
    query: 'SELECT st.total FROM stock_total st'
  });

  return result as TotalStockModel[];
}

export const update = async (id: string, data: Pick<StockModel, "amount">) => {
  await sql({
    query: `CALL updateProduitStock(?, ?)`,
    values: [id, data.amount]
  });

  return await read(id);
};

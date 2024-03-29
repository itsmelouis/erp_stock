import { useBase, createRouter, defineEventHandler } from 'h3';

import * as productCtrl from '~~/server/controller/product';
import * as categoryCtrl from '~~/server/controller/category';
import * as stockCtrl from '~~/server/controller/stock';

const router = createRouter();

//Route produits 
router.post('/product', defineEventHandler(productCtrl.create));
router.get('/product', defineEventHandler(productCtrl.readAll));
router.get('/product/:id', defineEventHandler(productCtrl.read));
router.put('/product/:id', defineEventHandler(productCtrl.update));
router.delete('/product/:id', defineEventHandler(productCtrl.remove));

//Route categories
router.post('/category', defineEventHandler(categoryCtrl.create));
router.get('/category', defineEventHandler(categoryCtrl.readAll));
router.get('/category/:id', defineEventHandler(categoryCtrl.read));
router.put('/category/:id', defineEventHandler(categoryCtrl.update));
router.delete('/category/:id', defineEventHandler(categoryCtrl.remove));

//Route stock
router.get('/stock', defineEventHandler(stockCtrl.readAllProductStock));
router.get('/stock/:id', defineEventHandler(stockCtrl.read));
router.get('/stock/total', defineEventHandler(stockCtrl.readTotalStock));
router.put('/stock/:id', defineEventHandler(stockCtrl.update));

export default useBase('/api', router.handler);

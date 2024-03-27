import { useBase, createRouter, defineEventHandler } from 'h3';

import * as productCtrl from '~~/server/controller/product';

const router = createRouter();

router.post('/product', defineEventHandler(productCtrl.create));
router.get('/product', defineEventHandler(productCtrl.readAll));
router.get('/product/:id', defineEventHandler(productCtrl.read));
router.put('/product/:id', defineEventHandler(productCtrl.update));
router.delete('/product/:id', defineEventHandler(productCtrl.remove));

export default useBase('/api', router.handler);

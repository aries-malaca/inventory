<?php

use Illuminate\Http\Request;

//products API
Route::get('/product/getProducts', 'ProductController@getProducts');
Route::get('/product/getProduct/{id}', 'ProductController@getProduct');
Route::post('/product/addProduct', 'ProductController@addProduct');
Route::post('/product/updateProduct', 'ProductController@updateProduct');
Route::post('/product/proceedConvert', 'ProductController@proceedConvert');

Route::get('/product/getPrices', 'ProductMiscController@getPrices');
Route::post('/product/addPrice', 'ProductMiscController@addPrice');
Route::post('/product/updatePrice', 'ProductMiscController@updatePrice');

Route::get('/product/getCategories', 'ProductMiscController@getCategories');
Route::post('/product/addCategory', 'ProductMiscController@addCategory');
Route::post('/product/updateCategory', 'ProductMiscController@updateCategory');
Route::get('/product/getTempID', 'ProductController@getTempID');
Route::post('/product/uploadPicture', 'ProductController@uploadPicture');
Route::post('/product/removePicture', 'ProductController@removePicture');
//Route::get('/product/mergeProductName', 'ProductController@mergeProductName');

Route::get('/product/getUnits', 'ProductMiscController@getUnits');
Route::post('/product/addUnit', 'ProductMiscController@addUnit');
Route::post('/product/updateUnit', 'ProductMiscController@updateUnit');
//end products API

//client API
Route::get('/client/getClients', 'ClientController@getClients');
Route::post('/client/addClient', 'ClientController@addClient');
Route::post('/client/updateClient', 'ClientController@updateClient');
//end client API

//supplier API
Route::get('/supplier/getSuppliers', 'SupplierController@getSuppliers');
Route::post('/supplier/addSupplier', 'SupplierController@addSupplier');
Route::post('/supplier/updateSupplier', 'SupplierController@updateSupplier');
//end supplier API


//settings API
Route::get('/settings/getSettings', 'SettingController@getSettings');
Route::post('/settings/updateSettings', 'SettingController@updateSettings');
//end settings API


























//branches API
Route::get('/branches/getBranches', 'BranchController@getBranches');
Route::post('/branches/addBranch', 'BranchController@addBranch');
Route::post('/branches/updateBranch', 'BranchController@updateBranch');
//end branches API


//profile API
Route::post('/profile/updateProfile', 'ProfileController@updateProfile');
//end profile API



//users API
Route::get('/users/getUsers', 'UserController@getUsers');
Route::get('/user/getUser', 'UserController@getUser');
Route::patch('/user/destroyToken', 'UserController@destroyToken');
Route::post('/users/addUser', 'UserController@addUser');
Route::post('/users/updateUser', 'UserController@updateUser');
//end users API

//levels API
Route::get('/levels/getLevels', 'LevelController@getLevels');
Route::post('/levels/addLevel', 'LevelController@addLevel');
Route::post('/levels/updateLevel', 'LevelController@updateLevel');
Route::post('/levels/deleteLevel', 'LevelController@deleteLevel');
//end levels API

//permissions API
Route::get('/permissions/getPermissions', 'PermissionController@getPermissions');
Route::post('/permissions/addPermission', 'PermissionController@addPermission');
Route::post('/permissions/updatePermission', 'PermissionController@updatePermission');
Route::post('/permissions/deletePermission', 'PermissionController@deletePermission');
//end permissions API

//profile API
Route::post('/profile/updateProfile', 'ProfileController@updateProfile');
Route::post('/profile/changePassword', 'ProfileController@changePassword');
//end profile API

//receives API
Route::get('/receives/getReceives', 'ReceiveController@getReceives');
Route::post('/receives/addReceive', 'ReceiveController@addReceive');
Route::post('/receives/cancelReceive', 'ReceiveController@cancelReceive');
Route::post('/receives/updateReceive', 'ReceiveController@updateReceive');
Route::post('/receives/voidReceive', 'ReceiveController@voidReceive');
Route::post('/receives/deleteReceive', 'ReceiveController@deleteReceive');
//end receives API


//receives API
Route::get('/reconciliations/getReconciliations', 'ReconciliationController@getReconciliations');
Route::get('/reconciliations/exportAsSales/{id}', 'ReconciliationController@exportAsSales');
Route::post('/reconciliations/addReconciliation', 'ReconciliationController@addReconciliation');
Route::post('/reconciliations/cancelReconciliation', 'ReconciliationController@cancelReconciliation');
Route::post('/reconciliations/updateReconciliation', 'ReconciliationController@updateReconciliation');
Route::post('/reconciliations/voidReconciliation', 'ReconciliationController@voidReconciliation');
Route::post('/reconciliations/deleteReconciliation', 'ReconciliationController@deleteReconciliation');
//end receives API

//purchases API
Route::get('/purchases/getPurchases', 'PurchaseController@getPurchases');
Route::post('/purchases/addPurchase', 'PurchaseController@addPurchase');
Route::post('/purchases/cancelPurchase', 'PurchaseController@cancelPurchase');
Route::post('/purchases/updatePurchase', 'PurchaseController@updatePurchase');
Route::post('/purchases/voidPurchase', 'PurchaseController@voidPurchase');
Route::post('/purchases/deletePurchase', 'PurchaseController@deletePurchase');
Route::get('/purchases/getPriceHistory/{id}', 'PurchaseController@getPriceHistory');
//end purchases API

//sales API
Route::get('/sales/getSales', 'SaleController@getSales');
Route::post('/sales/checkoutSale', 'SaleController@checkoutSale');
Route::post('/sales/cancelSale', 'SaleController@cancelSale');
Route::post('/sales/updateSale', 'SaleController@updateSale');
Route::post('/sales/voidSale', 'SaleController@voidSale');
Route::get('/sales/printReceipt/{id}', 'SaleController@printReceipt');
Route::get('/sales/getTempID', 'SaleController@getTempID');
Route::post('/sales/deleteSale', 'SaleController@deleteSale');
//end purchases API

//excel
Route::post('/reports/generateSalesReport', 'ReportController@generateSalesReport');
//excel

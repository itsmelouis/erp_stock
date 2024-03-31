<template>
  <Header />
  <div class="mt-20 px-20">
    <h1 class="font-bold text-4xl">Dashboard</h1>


    <div class="max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow mt-10">
      <div class="flex flex-row gap-2 items-center align-center">
        <Icon name="ant-design:stock-outlined" color="black" size="24px" />
        <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 ">Stock total</h5>
      </div>
      <p class="mb-3 ml-3 font-normal text-gray-700">+ {{ totalStock?.total_Stock_total }}</p>
    </div>

    <div class="mt-10">
      <div class="flex justify-between items-center">
        <h2 class="font-semibold text-xl">Catégories des produits</h2>
        <button @click="openModalCategory"
          class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">Ajouter
          une catégorie</button>
      </div>
      <div class="mt-5">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500">
          <thead class="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
              <th scope="col" class="px-6 py-3 rounded-s-lg">
                Nom
              </th>
              <th scope="col" class="px-6 py-3 rounded-e-lg">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            <tr class="bg-white " v-for="category in categories" :key="category.id_Categorie">
              <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                {{ category.nom_Categorie }}
              </th>
              <td class="flex px-6 py-4 gap-2">
                <NuxtLink :to="`/category/${category.id_Categorie}`"
                  class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                  Modifier
                </NuxtLink>
                <button @click="deleteCategory(category.id_Categorie)"
                  class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                  Supprimer
                </button>
              </td>
            </tr>
          </tbody>
        </table>

      </div>
    </div>

    <div class="mt-10">
      <div class="flex justify-between items-center">
        <h2 class="font-semibold text-xl">Produits disponibles</h2>
        <button @click="openModalProduct"
          class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">Ajouter
          un produit</button>
      </div>
      <div class="mt-5">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500">
          <thead class="text-xs text-gray-700 uppercase bg-gray-100">
            <tr>
              <th scope="col" class="px-6 py-3 rounded-s-lg">
                Nom
              </th>
              <th scope="col" class="px-6 py-3 rounded-s-lg">
                Description
              </th>
              <th scope="col" class="px-6 py-3">
                Qté
              </th>
              <th scope="col" class="px-6 py-3 rounded-e-lg">
                Prix
              </th>
              <th scope="col" class="px-6 py-3 rounded-e-lg">
                Catégorie
              </th>
              <th scope="col" class="px-6 py-3 rounded-e-lg">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="products" class="bg-white " v-for="product in products" :key="product.id_Produit">
              <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                {{ product.nom_Produit }}
              </th>
              <td class="px-6 py-4">
                {{ product.description_Produit }}
              </td>
              <td class="px-6 py-4">
                {{ product.quantite_dispo_Stock }}
              </td>
              <td class="px-6 py-4">
                {{ product.prix_unitaire_Produit }}€
              </td>
              <td class="px-6 py-4">
                {{ product.nom_Categorie }}
              </td>
              <td class="flex px-6 py-4 gap-2">
                <NuxtLink :to="`/product/${product.id_Produit}`"
                  class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                  Modifier
                </NuxtLink>
                <button @click="deleteProduct(product.id_Produit)"
                  class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
                  Supprimer
                </button>
              </td>
            </tr>
          </tbody>
        </table>

      </div>
    </div>
    <HTransitionRoot appear :show="isOpenProduct" as="template">
      <HDialog as="div" @close="closeModalProduct" class="relative z-10">
        <HTransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0" enter-to="opacity-100"
          leave="duration-200 ease-in" leave-from="opacity-100" leave-to="opacity-0">
          <div class="fixed inset-0 bg-black/25" />
        </HTransitionChild>

        <div class="fixed inset-0 overflow-y-auto">
          <div class="flex min-h-full items-center justify-center p-4 text-center">
            <HTransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0 scale-95"
              enter-to="opacity-100 scale-100" leave="duration-200 ease-in" leave-from="opacity-100 scale-100"
              leave-to="opacity-0 scale-95">
              <HDialogPanel
                class="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-al h-auto">
                <HDialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900">
                  Ajouter un produit
                </HDialogTitle>
                <div class="mt-8">


                  <div class="max-w-md mx-auto">

                    <div class="relative z-0 w-full mb-5 group">
                      <input type="text" name="floating_first_name" id="product_name"
                        class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                        placeholder=" " required v-model="productForm.nom_Produit" />
                      <label for="product_name"
                        class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nom
                        du produit</label>
                    </div>

                    <div class="relative z-0 w-full mb-5 group">
                      <input type="text" name="floating_first_name" id="product_name"
                        class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                        placeholder=" " required v-model="productForm.description_Produit" />
                      <label for="product_name"
                        class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Description
                        du produit</label>
                    </div>

                    <div class="relative z-0 w-full mb-5 group">
                      <input type="number" name="floating_first_name" id="product_name"
                        class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                        placeholder=" " required v-model="productForm.prix_unitaire_Produit" />
                      <label for="product_name"
                        class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Prix
                        du produit</label>
                    </div>
                    <div class="relative z-0 w-full mb-5 group">
                      <input type="number" name="floating_first_name" id="product_name"
                        class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                        placeholder=" " required v-model="productForm.quantite_dispo_Stock" />
                      <label for="product_name"
                        class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Quantité
                        du produit</label>
                    </div>
                    <div class="relative z-0 w-full mb-5 group">

                      <label for="categories" class="block mb-2 font-base text-sm text-gray-500 ">Choisir une catégorie</label>
                      <select id="categories" v-model="productForm.id_Categorie" name="categories"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 ">
                        <option v-for="category in categories" :key="category.id_Categorie" :selected="category.nom_Categorie === 'Ordinateurs'" :value="category.id_Categorie">{{ category.nom_Categorie }}</option>
                      </select>

                    </div>


                    <div class="flex flex-row gap-4 items-center">
                      <button @click="closeModalProduct"
                        class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">
                        Annuler
                      </button>
                      <button @click="onSubmitProduct" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                        Créer
                      </button>
                    </div>
                  </div>

                </div>
              </HDialogPanel>
            </HTransitionChild>
          </div>
        </div>
      </HDialog>
    </HTransitionRoot>

    <HTransitionRoot appear :show="isOpenCategory" as="template">
      <HDialog as="div" @close="closeModalCategory" class="relative z-10">
        <HTransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0" enter-to="opacity-100"
          leave="duration-200 ease-in" leave-from="opacity-100" leave-to="opacity-0">
          <div class="fixed inset-0 bg-black/25" />
        </HTransitionChild>

        <div class="fixed inset-0 overflow-y-auto">
          <div class="flex min-h-full items-center justify-center p-4 text-center">
            <HTransitionChild as="template" enter="duration-300 ease-out" enter-from="opacity-0 scale-95"
              enter-to="opacity-100 scale-100" leave="duration-200 ease-in" leave-from="opacity-100 scale-100"
              leave-to="opacity-0 scale-95">
              <HDialogPanel
                class="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-al h-auto">
                <HDialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900">
                  Ajouter une catégorie
                </HDialogTitle>
                <div class="mt-8">


                  <div class="max-w-md mx-auto">

                    <div class="relative z-0 w-full mb-5 group">
                      <input type="text" name="floating_first_name" id="product_name"
                        class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                        placeholder=" " required v-model="categoryForm.nom_Categorie" />
                      <label for="product_name"
                        class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nom de la catégorie</label>
                    </div>

                    <div class="flex flex-row gap-4 items-center">
                      <button @click="closeModalCategory"
                        class="bg-white hover:bg-gray-100 text-gray-800 font-semibold py-2 px-4 border border-gray-400 rounded shadow">
                        Annuler
                      </button>
                      <button @click="onSubmitCategory" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                        Créer
                      </button>
                    </div>
                  </div>

                </div>
              </HDialogPanel>
            </HTransitionChild>
          </div>
        </div>
      </HDialog>
    </HTransitionRoot>
  </div>
</template>


<script setup lang="ts">
import type { ProductModel } from '~/server/model/product';
import type { TotalStockModel } from '~/server/model/stock';
import type { CategoryModel } from '~/server/model/category';

const products = ref<ProductModel[]>([]);
const totalStock = ref<TotalStockModel>();
const categories = ref<CategoryModel[]>([]);

onMounted(fetchData);

const isOpenProduct = ref(false)
const isOpenCategory = ref(false)

function closeModalProduct() {
  isOpenProduct.value = false
}
function openModalProduct() {
  isOpenProduct.value = true
}

function closeModalCategory() {
  isOpenCategory.value = false
}
function openModalCategory() {
  isOpenCategory.value = true
}


async function fetchData() {
  try {
    const result = await $fetch('/api/product');
    const total = await $fetch('/api/stock/total');
    const categorie = await $fetch('/api/category');
    categories.value = categorie.data[0] as CategoryModel[];
    totalStock.value = total.data[0] as TotalStockModel;
    products.value = result.data[0] as ProductModel[];
  } catch (error) {
    alert('Fetch erreur (regardez console)');
    console.log('Fetch error: ', error);
  }
};

async function deleteProduct(id: string) {
  try {
    await $fetch(`/api/product/${id}`, {
      method: 'DELETE'
    });
    fetchData();
  } catch (error) {
    alert('Delete error');
    console.log('Delete error: ', error);
  }
}

async function deleteCategory(id: string) {
  try {
    await $fetch(`/api/category/${id}`, {
      method: 'DELETE'
    });
    fetchData();
  } catch (error) {
    alert('Delete error');
    console.log('Delete error: ', error);
  }
}

const productForm = reactive({
  nom_Produit: '',
  description_Produit: '',
  prix_unitaire_Produit: '',
  id_Categorie: '',
  quantite_dispo_Stock: ''
})

const categoryForm = reactive({
  nom_Categorie: ''
})

async function onSubmitProduct() {
  try {
    await $fetch('/api/product', {
      method: 'POST',
      body: productForm
    });
    fetchData();
    closeModalProduct()
  } catch (error) {
    alert('Post product error');
    console.log('Post product error: ', error);
  }
}

async function onSubmitCategory() {
  try {
    await $fetch('/api/category', {
      method: 'POST',
      body: categoryForm
    });
    fetchData();
    closeModalCategory()
  } catch (error) {
    alert('Post category error');
    console.log('Post category error: ', error);
  }
}
</script>

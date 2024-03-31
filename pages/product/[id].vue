<template>
  <Header />
  <div class="w-full max-w-3xl mx-auto py-8">
    <div class="text-xl font-semibold">Mettre à jour un produit</div>

    <div class="mt-6 mb-6">
      <label for="nom_Produit" class="block mb-2 text-sm font-medium text-gray-900">Nom</label>
      <input v-model="form.nom_Produit" type="text" id="nom_Produit"
        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
        required />
    </div>

    <div class="mb-6">
      <label for="description" class="block mb-2 text-sm font-medium text-gray-900">Description</label>
      <textarea v-model="form.description_Produit" id="description" rows="4"
        class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500"></textarea>
    </div>

    <div class="mb-6">
      <label for="nom_Produit" class="block mb-2 text-sm font-medium text-gray-900">Prix</label>
      <input v-model="form.quantite_dispo_Stock" type="number" id="nom_Produit"
        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
        required />
    </div>

    <div class="mb-6">
      <label for="categories" class="block mb-2 font-base text-sm text-gray-500 ">Catégorie</label>
      <select id="categories" v-model="form.id_Categorie" name="categories"
        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 ">
        <option v-for="category in categories" :key="category.id_Categorie"
          :selected="category.nom_Categorie === 'Ordinateurs'" :value="category.id_Categorie">{{ category.nom_Categorie
          }}</option>
      </select>
    </div>

    <div class="mb-6">
      <label for="nom_Produit" class="block mb-2 text-sm font-medium text-gray-900">Quantité</label>
      <input v-model="form.quantite_dispo_Stock" type="number" id="nom_Produit"
        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5"
        required />
    </div>

    <div class="relative flex justify-end mb-7">
      <NuxtLink to="/"
        class="text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 focus:outline-none mr-2">
        Retour
      </NuxtLink>
      <button @click="onSubmit"
        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 focus:outline-none">
        Soumettre
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { ProductModel } from '~/server/model/product';
import type { CategoryModel } from '~/server/model/category';
useHead({
  title: 'Produit | ERP Stock'
});

const categories = ref<CategoryModel[]>([]);


const form = reactive({
  nom_Produit: '',
  description_Produit: '',
  prix_unitaire_Produit: '',
  id_Categorie: '',
  quantite_dispo_Stock: ''
});

const route = useRoute();
const router = useRouter();

const onSubmit = async () => {
  try {
    await $fetch('/api/product/' + route.params.id, {
      method: 'PUT',
      body: form
    });

    router.push('/');
  } catch {
    alert('Post blog error');
  }
};

const fetchData = async () => {
  try {
    const result = (await $fetch('/api/product/' + route.params.id)) as any;
    const data = result.data as ProductModel;

    const categorie = await $fetch('/api/category');
    categories.value = categorie.data[0] as CategoryModel[];

    form.nom_Produit = data.nom_Produit;
    form.description_Produit = data.description_Produit;
    form.prix_unitaire_Produit = data.prix_unitaire_Produit.toString();
    form.id_Categorie = data.id_Categorie;
    form.quantite_dispo_Stock = data.quantite_dispo_Stock!.toString();
  } catch (error) {
    alert('Get blog detail error: ' + error);
  }
};

onMounted(fetchData);
</script>

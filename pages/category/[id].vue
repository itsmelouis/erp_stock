<template>
  <Header />
  <div class="w-full max-w-3xl mx-auto py-8">
    <div class="text-xl font-semibold">Mettre à jour une catégorie</div>

    <div class="mt-6 mb-6">
      <label for="nom_Categorie" class="block mb-2 text-sm font-medium text-gray-900">Nom</label>
      <input v-model="form.nom_Categorie" type="text" id="nom_Categorie"
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
import type { CategoryModel } from '~/server/model/category';
useHead({
  title: 'Update Page'
});


const form = reactive({
  nom_Categorie: '',
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
    const result = (await $fetch('/api/category/' + route.params.id)) as any;
    const data = result.data as CategoryModel;

    form.nom_Categorie = data.nom_Categorie;
  } catch (error) {
    alert('Get blog detail error: ' + error);
  }
};

onMounted(fetchData);
</script>

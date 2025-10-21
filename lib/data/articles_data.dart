// articles_data.dart
import '../models/article.dart';

final allArticles = [
  Article(
    title: 'Rainforest Secrets',
    category: 'Geography',
    description: 'Explore the hidden wonders of rainforests.',
    contents: [
      Content(
        type: ContentType.text,
        data: '''
Rainforests are Earth's oldest living ecosystems, with some surviving in their present form for at least 60 million years. They are incredibly diverse and complex, housing more than half of the world’s plant and animal species, despite covering just two to six percent of Earth’s surface.

Rainforests play a crucial role in regulating the global climate by absorbing and storing carbon dioxide, producing oxygen, and stabilizing rainfall patterns. They also provide food, medicine, and shelter to countless species, many of which are yet to be discovered.

However, these vital ecosystems are under threat due to deforestation, climate change, and illegal logging. Protecting rainforests is essential for maintaining biodiversity and combating climate change.
      ''',
      ),
      Content(
        type: ContentType.image,
        data: 'https://www.rainforest-alliance.org/wp-content/uploads/2021/06/Peruvian-Amazon-Tambopata-Reserve.jpg',
      ),
      Content(
        type: ContentType.image,
        data: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRnaJIPycSxRM2Agoj0jrwb4Zu_WRnHjk78LG_-CvwNACePamFLURclRM2ooaWu-iD6tbuX0fRS',
      ),
      Content(
        type: ContentType.video,
        data: 'https://www.youtube.com/watch?v=3vijLre760w',
      ),
      Content(
        type: ContentType.reference,
        data: 'Rainforests 101 | National Geographic',
      ),
    ],
  ),
  Article(
    title: 'Mountain Ecosystems',
    category: 'Geography',
    description: 'Discover life at high altitudes.',
    contents: [
      Content(type: ContentType.text, data: 'Mountains host unique flora and fauna adapted to harsh conditions.'),
      Content(type: ContentType.image, data: 'assets/images/mountains.jpg'),
    ],
  ),
  Article(
    title: 'Ocean Mysteries',
    category: 'Geography',
    description: 'Dive into the deep blue world of oceans.',
    contents: [
      Content(type: ContentType.text, data: 'Oceans cover 71% of the Earth’s surface and are home to diverse life forms.'),
      Content(type: ContentType.image, data: 'assets/images/ocean.jpg'),
    ],
  ),
  Article(
    title: 'Desert Life',
    category: 'Geography',
    description: 'Survival strategies in arid lands.',
    contents: [
      Content(type: ContentType.text, data: 'Deserts are harsh environments with plants and animals adapted to extreme dryness.'),
      Content(type: ContentType.image, data: 'assets/images/desert.jpg'),
    ],
  ),
  Article(
    title: 'Quantum Computing',
    category: 'Science',
    description: 'The future of computation.',
    contents: [
      Content(type: ContentType.text, data: 'Quantum computers use qubits to perform complex calculations faster than classical computers.'),
    ],
  ),
  Article(
    title: 'AI Ethics',
    category: 'Science',
    description: 'Moral implications of artificial intelligence.',
    contents: [
      Content(type: ContentType.text, data: 'AI ethics deals with bias, privacy, and the impact on jobs.'),
    ],
  ),
  Article(
    title: 'Climate Change',
    category: 'Science',
    description: 'Understanding global warming.',
    contents: [
      Content(type: ContentType.text, data: 'Climate change is driven by greenhouse gases and affects weather patterns worldwide.'),
    ],
  ),
  Article(
    title: 'Renewable Energy',
    category: 'Science',
    description: 'Sustainable power sources.',
    contents: [
      Content(type: ContentType.text, data: 'Solar, wind, and hydro power are key to reducing fossil fuel dependency.'),
    ],
  ),
  Article(
    title: 'Blockchain Basics',
    category: 'Technology',
    description: 'Understanding decentralized ledgers.',
    contents: [
      Content(type: ContentType.text, data: 'Blockchain is the technology behind cryptocurrencies like Bitcoin.'),
    ],
  ),
  Article(
    title: 'Web 3.0',
    category: 'Technology',
    description: 'The next evolution of the internet.',
    contents: [
      Content(type: ContentType.text, data: 'Web 3.0 aims to decentralize the internet using blockchain.'),
    ],
  ),
  Article(
    title: 'Robotics Today',
    category: 'Technology',
    description: 'Modern robotics applications.',
    contents: [
      Content(type: ContentType.text, data: 'Robots are being used in factories, healthcare, and exploration.'),
    ],
  ),
  Article(
    title: 'Healthy Eating',
    category: 'Health',
    description: 'Simple tips for a balanced diet.',
    contents: [
      Content(type: ContentType.text, data: 'Eat fruits, vegetables, whole grains, and drink plenty of water.'),
      Content(type: ContentType.image, data: 'https://www.healthline.com/hlcmsresource/images/AN_images/fruit-and-vegetables-1296x728-header.jpg'), // Placeholder health image
    ],
  ),
  Article(
    title: 'Mindfulness 101',
    category: 'Health',
    description: 'Improve mental well-being through mindfulness.',
    contents: [
      Content(type: ContentType.text, data: 'Mindfulness meditation can reduce stress and improve focus.'),
      Content(type: ContentType.image, data: 'https://www.healthline.com/hlcmsresource/images/AN_images/meditation-1296x728-header.jpg'), // Placeholder health image
    ],
  ),
  Article(
    title: 'Fitness at Home',
    category: 'Health',
    description: 'Easy exercises without equipment.',
    contents: [
      Content(type: ContentType.text, data: 'Bodyweight exercises like squats, push-ups, and planks are effective.'),
      Content(type: ContentType.image, data: 'https://www.healthline.com/hlcmsresource/images/AN_images/home-workout-1296x728-header.jpg'), // Placeholder health image
    ],
  ),
  Article(
    title: 'Sleep Science',
    category: 'Health',
    description: 'Why good sleep matters.',
    contents: [
      Content(type: ContentType.text, data: 'Sleep is crucial for memory, mood, and overall health.'),
      Content(type: ContentType.image, data: 'https://www.healthline.com/hlcmsresource/images/AN_images/sleep-1296x728-header.jpg'), // Placeholder health image
    ],
  ),
  Article(
    title: 'Ancient Civilizations',
    category: 'History',
    description: 'Discover the early human societies.',
    contents: [
      Content(type: ContentType.text, data: 'Early civilizations like Mesopotamia and Egypt shaped human history.'),
    ],
  ),
  Article(
    title: 'World Wars Overview',
    category: 'History',
    description: 'Key events that shaped the 20th century.',
    contents: [
      Content(type: ContentType.text, data: 'WWI and WWII changed nations, politics, and societies globally.'),
    ],
  ),
  Article(
    title: 'Industrial Revolution',
    category: 'History',
    description: 'The era that changed the world.',
    contents: [
      Content(type: ContentType.text, data: 'Mechanization and factories transformed economies and lifestyles.'),
    ],
  ),
  Article(
    title: 'Modern History Highlights',
    category: 'History',
    description: 'Important global milestones.',
    contents: [
      Content(type: ContentType.text, data: 'Recent history includes technological, political, and social changes worldwide.'),
    ],
  ),
  Article(
    title: 'Socratic Wisdom',
    category: 'Philosophy',
    description: 'The paradox of knowing nothing.',
    contents: [
      Content(
        type: ContentType.text,
        data: 'Socrates once said: \'the only thing I know is that I know nothing.\' This statement emphasizes the value of humility and continuous learning in philosophy.',
      ),
      Content(
        type: ContentType.image,
        data: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/David_-_The_Death_of_Socrates.jpg',
      ),
    ],
  ),
  Article(
    title: 'Diogenes and Simple Living',
    category: 'Philosophy',
    description: 'The Cynic who lived in a barrel.',
    contents: [
      Content(
        type: ContentType.text,
        data: 'Ancient Greek philosopher Diogenes believed in living a simple life. So much so, that he gave up all his possessions and spent some time living in a barrel.',
      ),
      Content(
        type: ContentType.image,
        data: 'https://upload.wikimedia.org/wikipedia/commons/2/23/Alexander_visits_Diogenes_living_in_a_barrel_at_Corinth_in_an_early_19th_century_engraving.jpg',
      ),
    ],
  ),
  Article(
    title: 'Pythagoras and Equality',
    category: 'Philosophy',
    description: 'Early supporter of women’s rights.',
    contents: [
      Content(
        type: ContentType.text,
        data: 'Philosopher and mathematician Pythagoras was an early supporter of women’s rights. He started a school in around 530 BC in which he taught both men and women.',
      ),
      Content(
        type: ContentType.image,
        data: 'https://cdn.britannica.com/57/127557-050-3757A37F/Pythagoras-portrait-bust.jpg',
      ),
    ],
  ),
  Article(
    title: 'Aristotle on Self-Knowledge',
    category: 'Philosophy',
    description: 'The beginning of wisdom.',
    contents: [
      Content(
        type: ContentType.text,
        data: 'Aristotle said: ‘Knowing yourself is the beginning of all wisdom.’ This highlights the importance of self-reflection in philosophical thought.',
      ),
      Content(
        type: ContentType.image,
        data: 'https://cdn.britannica.com/84/87984-050-7C5547FE/Detail-Roman-copy-portrait-bust-Aristotle-Greek.jpg',
      ),
    ],
  ),
];